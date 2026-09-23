"""Contains SuperHash and all closely related children"""

from __future__ import annotations

import logging
import os
import re
from collections import UserDict
from typing import Any, ClassVar

from .CrunchLog import (
    ApacheAccessEntry,
    ApacheErrorEntry,
    CrunchLog,
    RawEntry,
    RSyslogEntry,
    SecureLogEntry,
    SnortEntry,
    SyslogEntry,
)
from .errors import DataFileError, PetitError
from .Filter import Filter
from .resources import search_prefixes

# Share of a fingerprint corpus's patterns that must appear before the
# corpus is considered present.
FINGERPRINT_THRESHOLD = 0.31

# (path, mtime) -> the corpus's fingerprint keys. Parsing the corpora is
# thousands of lines of work; an embedding service asks on every request.
_FINGERPRINT_CACHE: dict[tuple[str, float], frozenset[str]] = {}


def load_fingerprints() -> list[tuple[str, frozenset[str]]]:
    """Every fingerprint corpus as (name, keys), largest file first.

    Largest first prevents double labelling when a smaller corpus is a
    subset of a bigger one. Only the first search prefix holding any files
    is used, so a site-local directory replaces the packaged corpora rather
    than mixing with them. Each corpus is hashed by whatever driver claims
    it, with that driver's own default filter.
    """
    prefixes = search_prefixes("fingerprints")
    paths: list[str] = []
    for prefix in prefixes:
        if os.path.isdir(prefix) and os.listdir(prefix):
            paths = [os.path.join(prefix, f) for f in os.listdir(prefix)]
            break
    if not paths:
        raise DataFileError(
            "could not locate fingerprint files in any of: " + ", ".join(prefixes)
        )
    paths.sort(key=os.path.getsize, reverse=True)

    corpora = []
    for path in paths:
        if not path.endswith(".fp"):
            continue
        cache_key = (path, os.path.getmtime(path))
        keys = _FINGERPRINT_CACHE.get(cache_key)
        if keys is None:
            keys = frozenset(SuperHash.manufacture(CrunchLog(path)).keys())
            _FINGERPRINT_CACHE[cache_key] = keys
        corpora.append((os.path.basename(path), keys))
    return corpora


class SuperHash(UserDict[str, list[Any]]):
    """Interface and parent class for all hash/dict based objects. """

    filter = Filter()
    sample = "none"
    file_name = ""

    # The stopword file this driver normalises with unless the caller says
    # otherwise. The driver knows what noise looks like in its format; the
    # caller does not, so the default belongs here and not in analyze_text.
    DEFAULT_FILTER: ClassVar[str] = "hash.stopwords"

    def __init__(self, log: CrunchLog, filter_filename: str | Filter | None = None) -> None:

        # Call parent init
        UserDict.__init__(self)

        # None asks the driver. A caller that supplies its own normalisation
        # policy passes a built Filter instead of the name of one to find.
        if filter_filename is None:
            filter_filename = self.DEFAULT_FILTER
        if isinstance(filter_filename, Filter):
            self.filter = filter_filename
        elif filter_filename != "__none__":
            self.filter = Filter(filter_filename)

        self.fill(log)

    def fill(self, log: CrunchLog) -> None:
        """Interface method which is flled in by subclasses"""

    def increment(self, key: str, entry: object) -> None:
        """Adds a new entry to superhash data structures.
        Similar to append for a list"""

        # Check to make sure it exists
        if key not in self:
            self[key] = [0, []]

        self[key][0] += 1
        self[key][1].append(entry)

    def display(self) -> None:
        """Displays all entries held in the SuperHash structure"""

        # Set static sample threshold
        sample_threshold = 3

        # Debugging
        logging.info("Sample Type: " + self.sample)

        # Print out the dictionary first sorted by the word with
        # the most entries with an alphabetical subsort
        for key in sorted(sorted(self.keys()),
                key=lambda k: self[k][0],
                reverse=True):

            # Print all lines as sample
            if self.sample == "all":
                print(str(self[key][0]) + ":\t" + self[key][1][0].log_entry)

            elif self.sample == "none":
                print(str(self[key][0]) + ":\t" + str(key))

            elif self.sample == "threshold":
                # Print sample for small values below/equal to threshold
                if self[key][0] <= sample_threshold:
                    print(str(self[key][0]) + ":\t" +
                    self[key][1][0].log_entry)
                else:
                    print(str(self[key][0]) + ":\t" + str(key))
            else:
                raise PetitError(
                    "unsupported sampling mode: " + str(self.sample)
                )

    def fingerprint(self) -> list[str]:
        """Collapse every known event sequence found in this hash.

        A fingerprint is a corpus of the lines one routine event produces — a
        reboot, say. When more than FINGERPRINT_THRESHOLD of a corpus's
        patterns are present, every one of them is removed and replaced by a
        single group named after the corpus, so 600 lines of boot noise read
        as one line and whatever was unusual stands out.

        Returns the names of the corpora that matched, in the order they did,
        so a caller can tell "nothing matched" from "not asked".
        """
        matched: list[str] = []
        for name, keys in load_fingerprints():
            count = sum(1 for key in keys if key in self)
            logging.info("Fingerprint %s: %d of %d patterns", name, count, len(keys))
            if count <= len(keys) * FINGERPRINT_THRESHOLD:
                continue

            for key in keys:
                self.pop(key, None)

            # The collapsed group stands for lines that are gone, so its one
            # member is made up here and named after the corpus. It used to
            # be the corpus's own parsed entry with its payload overwritten,
            # which mutated the loaded fingerprint — harmless only while
            # nothing kept the corpus around between calls.
            stand_in = RawEntry(name)
            stand_in.raw = name
            self.increment(name, stand_in)
            matched.append(name)
        return matched

    @staticmethod
    def manufacture(log: CrunchLog, filter: str | Filter | None = None) -> SuperHash:
        """Factory method which creates new SuperHash of correct subtype"""

        # Select the correct build method
        log_hash_class: type[SuperHash]
        if log.contains(SyslogEntry) or log.contains(RSyslogEntry):
            log_hash_class = SyslogHash
        elif log.contains(ApacheAccessEntry) or log.contains(ApacheErrorEntry):
            log_hash_class = ApacheLogHash
        elif log.contains(SnortEntry):
            log_hash_class = SnortLogHash
        elif log.contains(RawEntry):
            log_hash_class = RawLogHash
        elif log.contains(SecureLogEntry):
            log_hash_class = SecureLogHash
        else:
            raise PetitError(
                "could not determine what type of objects the log contains"
            )

        return log_hash_class(log, filter)


class SyslogHash(SuperHash):
    """Overrides the fill method specifically for LogHashes built from Syslog files"""

    def fill(self, log: CrunchLog) -> None:
        for entry in log:

            # Scrub sections of SyslogEntry which will be used to key the hash
            key = self.filter.scrub(entry.daemon + " " + entry.log_entry)

            # increment the LogHash with the new key
            self.increment(key, entry)

        # Finally, remove valueless lines
        if "#" in self:
            del self["#"]


class ApacheLogHash(SuperHash):
    """Overrides the fill method specifically for LogHashes built from Apache logs"""

    def fill(self, log: CrunchLog) -> None:
        for entry in log:

            # Scrub sections of SyslogEntry which will be used to key the hash
            key = self.filter.scrub(entry.log_entry)

            # increment the LogHash with the new key
            self.increment(key, entry)

        # Finally, remove valueless lines
        if "#" in self:
            del self["#"]


class SnortLogHash(SuperHash):
    """Overrides the fill method specifically for LogHashes built from Snort logs"""

    def fill(self, log: CrunchLog) -> None:
        for entry in log:

            # Scrub sections of SyslogEntry which will be used to key the hash
            key = self.filter.scrub(entry.log_entry)

            # increment the LogHash with the new key
            self.increment(key, entry)

        # Finally, remove valueless lines
        if "#" in self:
            del self["#"]


class SecureLogHash(SuperHash):
    """Overrides the fill method specifically for LogHashes built from Syslog files"""

    # Each rule collapses everything after a phrase sshd is known to emit,
    # which is what makes a secure log group at all: the variable half is
    # the user, host or port, and that is precisely what differs line to
    # line. Applied to the key only — see fill().
    GENERALIZATIONS: ClassVar[list[tuple[re.Pattern[str], str]]] = [
        # Session entries
        (re.compile("session closed for.*"), "session closed for #"),
        (re.compile("session opened for.*"), "session opened for #"),
        # Auth entries
        (re.compile("Accepted publickey for.*"), "Accepted publickey for #"),
        (re.compile("Accepted password for.*"), "Accepted password for #"),
        (re.compile("Postponed publickey for.*"), "Postponed publickey for #"),
        (re.compile("input_userauth_request: invalid user.*"),
         "input_userauth_request: invalid user #"),
        (re.compile("Invalid user.*"), "Invalid user #"),
        (re.compile("reverse mapping checking getaddrinfo for.*"),
         "reverse mapping checking getaddrinfo for #"),
        (re.compile("Connection closed by.*"), "Connection closed by #"),
        (re.compile("Failed password for invalid user.*"),
         "Failed password for invalid user #"),
        (re.compile("Failed password for.*from.*"), "Failed password for # from #"),
        (re.compile("error retrieving information about user.*"),
         "error retrieving information about user #"),
        (re.compile("authentication failure.*"), "authentication failure #"),
        # Misc
        (re.compile("Received disconnect from.*"), "Received disconnect from #"),
        (re.compile("Could not reverse map address.*"), "Could not reverse map address #"),
    ]

    def generalize(self, payload: str) -> str:
        """Return `payload` with sshd's variable tails collapsed."""
        for pattern, replacement in self.GENERALIZATIONS:
            payload = pattern.sub(replacement, payload)
        return payload

    def fill(self, log: CrunchLog) -> None:
        for entry in log:

            # Generalise sshd's vocabulary to build the key. This used to
            # assign back to entry.log_entry, which mutated the log itself:
            # after hashing, every sample the caller could reach had been
            # overwritten with the generalised form, and the actual user
            # name, source address or failure reason was gone for good.
            # Fingerprinting is supposed to describe the entry, not consume
            # it — so generalise into a local and leave the entry alone.
            payload = self.generalize(entry.log_entry)

            # Scrub sections of SyslogEntry which will be used to key the hash
            key = self.filter.scrub(entry.daemon + " " + payload)

            # increment the LogHash with the new key
            self.increment(key, entry)

        # Finally, remove valueless lines
        if "#" in self:
            del self["#"]


class RawLogHash(SuperHash):
    """Overrides the fill method for LogHashes built from text files without date/time"""

    def fill(self, log: CrunchLog) -> None:
        for entry in log:

            # Scrub sections of SyslogEntry which will be used to key the hash
            key = self.filter.scrub(entry.log_entry)

            # increment the LogHash with the new key
            self.increment(key, entry)

        # Finally, remove valueless lines
        if "#" in self:
            del self["#"]


class DaemonHash(SyslogHash):
    """Overrides the fill method for DaemonHashes built from text files with date/time"""

    DEFAULT_FILTER: ClassVar[str] = "daemon.stopwords"

    def fill(self, log: CrunchLog) -> None:

        for entry in log:

            # Scrub sections of SyslogEntry which will be used to key the hash
            key = self.filter.scrub(entry.daemon)

            # increment the LogHash with the new key
            self.increment(key, entry)

        # Finally, remove valueless lines
        if "#" in self:
            del self["#"]


class HostHash(SyslogHash):
    """Overrides the fill method for HostHashes built from text files with date/time"""

    DEFAULT_FILTER: ClassVar[str] = "host.stopwords"

    def fill(self, log: CrunchLog) -> None:

        for entry in log:

            # Scrub sections of SyslogEntry which will be used to key the hash
            key = self.filter.scrub(entry.host)

            # increment the LogHash with the new key
            self.increment(key, entry)

        # Finally, remove valueless lines
        if "#" in self:
            del self["#"]


class WordHash(SuperHash):
    """
    Subclass which creates a dictionary of words which may hold value in a given log file
    Date, time, and other common words are excluded from the count.
    """

    DEFAULT_FILTER: ClassVar[str] = "words.stopwords"

    def fill(self, log: CrunchLog) -> None:

        for entry in log:

            # Base the wordcount on the log_entry payload
            for word in entry.log_entry.split():

                # Keep the entry, not the word, so a group's members are
                # the lines the word appeared in
                self.increment(word, entry)

        # Perform bleach at the end because it is more efficient
        for key in list(self.keys()):

            # First scrub any unwanted words
            newkey = self.filter.scrub(key)
            if newkey in self:
                self[newkey] = self[newkey] + self[key]
            else:
                self[newkey] = self[key]

            if newkey != key:
                del self[key]

        # Finally, remove valueless lines
        if "#" in self:
            del self["#"]
