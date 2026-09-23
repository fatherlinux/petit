"""Hash drivers: SuperHash and the per-format classes that fingerprint entries.

A hash driver turns each parsed entry into a fingerprint key. It declares
three things and inherits the rest:

- KEY_FIELDS: which LogEntry fields make up the key.
- GENERALIZATIONS: (pattern, replacement) rules for the format's phrases.
- DEFAULT_FILTER: the stopword file used unless the caller supplies one.

The rule for GENERALIZATIONS:

    A generalization is a claim that everything after this phrase is a
    parameter, not a message. Normalize what the FORMAT generated; keep
    what a HUMAN wrote.

Ask two questions of a rule. Does it collapse a token or a phrase?
Token-level rules — timestamps, addresses, hex, PIDs — are always safe; a
token cannot carry a sentence. Phrase-level rules are allowed only when the
tail they swallow is drawn from a bounded, machine-generated vocabulary.
Then: what is the widest thing this rule's `.*` can swallow? If the format
permits free text there, the rule is too wide. docs/drivers.md has more.
"""

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
    LogEntry,
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
    subset of a bigger one. Every search prefix contributes: the packaged
    corpora plus any site-local .fp files. Only the first directory holding
    files used to count, and the packaged one always does, so a site-local
    corpus was never read. Where two share a name, the earlier prefix wins.
    Each corpus is hashed by whatever driver claims it, with that driver's
    own default filter.
    """
    prefixes = search_prefixes("fingerprints")
    by_name: dict[str, str] = {}
    for prefix in prefixes:
        if not os.path.isdir(prefix):
            continue
        for name in sorted(os.listdir(prefix)):
            if name.endswith(".fp"):
                by_name.setdefault(name, os.path.join(prefix, name))
    if not by_name:
        raise DataFileError(
            "could not locate fingerprint files in any of: " + ", ".join(prefixes)
        )
    paths = sorted(by_name.values(), key=os.path.getsize, reverse=True)

    corpora = []
    for path in paths:
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

    # Which LogEntry fields, joined by a space, make up the fingerprint.
    KEY_FIELDS: ClassVar[tuple[str, ...]] = ("log_entry",)

    # (pattern, replacement) rules applied to the key before the filter.
    # See the module docstring for what a rule here is allowed to swallow.
    GENERALIZATIONS: ClassVar[list[tuple[re.Pattern[str], str]]] = []

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

    def generalize(self, text: str) -> str:
        """Return `text` with this format's variable phrases collapsed."""
        for pattern, replacement in self.GENERALIZATIONS:
            text = pattern.sub(replacement, text)
        return text

    def key_for(self, entry: LogEntry) -> str:
        """The fingerprint of one entry: its key fields, generalised, then scrubbed.

        Built into a local, never written back. SecureLogHash used to assign
        its generalised payload onto the entry, which destroyed the user
        name and source address for every later reader of the log.
        """
        text = " ".join(getattr(entry, name) for name in self.KEY_FIELDS)
        return self.filter.scrub(self.generalize(text))

    def fill(self, log: CrunchLog) -> None:
        """Group every entry under its fingerprint."""
        for entry in log:
            self.increment(self.key_for(entry), entry)

        # An entry that scrubs away to nothing carries no information
        self.pop("#", None)

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
    """Syslog and rsyslog: the daemon and its message."""

    KEY_FIELDS: ClassVar[tuple[str, ...]] = ("daemon", "log_entry")


class ApacheLogHash(SuperHash):
    """Apache access and error logs: the request or message."""


class SnortLogHash(SuperHash):
    """Snort alerts: the alert text."""


class SecureLogHash(SuperHash):
    """sshd and PAM entries from a secure/auth log."""

    KEY_FIELDS: ClassVar[tuple[str, ...]] = ("daemon", "log_entry")

    # Each rule collapses the machine-generated tail after a phrase sshd or
    # PAM emits: the host, port or session detail that differs line to line.
    # A user name is chosen by whoever is knocking, so it is kept verbatim:
    # the rule captures exactly one token for it and matches nothing at all
    # if the name has a space in it, rather than swallowing the rest.
    GENERALIZATIONS: ClassVar[list[tuple[re.Pattern[str], str]]] = [
        # Session entries
        (re.compile("session closed for.*"), "session closed for #"),
        (re.compile("session opened for.*"), "session opened for #"),
        # Auth entries
        (re.compile("Accepted publickey for.*"), "Accepted publickey for #"),
        (re.compile("Accepted password for.*"), "Accepted password for #"),
        (re.compile("Postponed publickey for.*"), "Postponed publickey for #"),
        (re.compile(r"Invalid user (\S+) from \S+"), r"Invalid user \1 from #"),
        (re.compile("reverse mapping checking getaddrinfo for.*"),
         "reverse mapping checking getaddrinfo for #"),
        (re.compile("Connection closed by.*"), "Connection closed by #"),
        (re.compile(r"Failed password for invalid user (\S+) from \S+"),
         r"Failed password for invalid user \1 from #"),
        (re.compile(r"Failed password for (\S+) from \S+"), r"Failed password for \1 from #"),
        (re.compile("authentication failure.*"), "authentication failure #"),
        # Misc
        (re.compile("Received disconnect from.*"), "Received disconnect from #"),
        (re.compile("Could not reverse map address.*"), "Could not reverse map address #"),
    ]


class RawLogHash(SuperHash):
    """Text no driver recognised: the whole line, structurally normalised.

    Nothing is known about the format, so nothing format-specific is
    collapsed. strict.stopwords normalises shapes that are unambiguous —
    timestamps, UUIDs, addresses, standalone numbers — and leaves
    identifiers like web01 or PROJ-1234 distinct.
    """

    DEFAULT_FILTER: ClassVar[str] = "strict.stopwords"


class DaemonHash(SyslogHash):
    """Counts entries per daemon."""

    DEFAULT_FILTER: ClassVar[str] = "daemon.stopwords"
    KEY_FIELDS: ClassVar[tuple[str, ...]] = ("daemon",)


class HostHash(SyslogHash):
    """Counts entries per host."""

    DEFAULT_FILTER: ClassVar[str] = "host.stopwords"
    KEY_FIELDS: ClassVar[tuple[str, ...]] = ("host",)


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
