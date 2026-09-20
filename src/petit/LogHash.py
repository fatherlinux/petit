"""Contains SuperHash and all closely related children"""

from __future__ import annotations

import logging
import os
import re
from collections import UserDict
from random import choice
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


class SuperHash(UserDict[str, list[Any]]):
    """Interface and parent class for all hash/dict based objects. """

    filter = Filter()
    sample = "none"
    file_name = ""

    def __init__(self, log: CrunchLog, filter_filename: str | Filter = "__none__") -> None:

        # Call parent init
        UserDict.__init__(self)

        # A caller that supplies its own normalisation policy passes a built
        # Filter instead of the name of one to go and find.
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
                print(str(self[key][0]) + ":\t" +
                choice(self[key][1]).log_entry)

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

    def fingerprint(self) -> None:
        """
        Remove all fingerprints from a given LogHash and replace with a
        single string"
        """

        # Declarations & Variables
        threshold_coefficient = 0.31
        fingerprints = []
        fingerprint_files = ["__none__"]

        # Load & assign fingerprint files
        prefixes = search_prefixes("fingerprints")

        for prefix in prefixes:
            if os.path.exists(prefix) and len(os.listdir(prefix)) >= 1:

                # Process in order from largest to smallest which prevents
                # double labeling with similar fingerprints
                fingerprint_files = os.listdir(prefix)
                fingerprint_files = [os.path.join(prefix, f) for f in fingerprint_files]
                fingerprint_files.sort(key=os.path.getsize)
                fingerprint_files.reverse()
                break

        if fingerprint_files[0] == "__none__":
            raise DataFileError(
                "could not locate fingerprint files in any of: "
                + ", ".join(prefixes)
            )

        for fingerprint_file in fingerprint_files:
            if re.search("fp", fingerprint_file):

                # Build a Log for the fingerprint
                log = CrunchLog(fingerprint_file)

                # Build a SuperHash
                x = SuperHash.manufacture(log, "hash.stopwords")

                # Remove the prefix & set name
                x.file_name = re.sub(prefix, "", fingerprint_file)
                fingerprints.append(x)

        # Iterate each fingerprint
        for fingerprint in fingerprints:

            logging.info("Testing Fingerprint:" + fingerprint.file_name)

            # Reset counter for each fingerprint
            count = 0
            threshold = (len(fingerprint) * threshold_coefficient)
            logging.info("Threshold:" + str(threshold))

            # Look for fingerpring
            for key in list(fingerprint.keys()):
                if key in self:
                    count = count + 1

                # If Threshold is reached, remove everyline of fingerprint
                # Saves time on searching every entry
                if count > threshold:
                    logging.info("Found Fingerprint:" + fingerprint.file_name)
                    matched_key = key
                    for fingerprint_key in fingerprint:
                        if fingerprint_key in self:
                            del self[fingerprint_key]

                    # Force the sample entry to be the same as the key
                    # and based off of the filename of the fingerprint
                    fingerprint[matched_key][1][0].log_entry = fingerprint.file_name
                    self.increment(fingerprint.file_name, fingerprint[matched_key][1][0])
                    break

            logging.info("Count: " + str(count))

    @staticmethod
    def manufacture(log: CrunchLog, filter: str | Filter) -> SuperHash:
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

    def fill(self, log: CrunchLog) -> None:

        for entry in log:

            # Base the wordcount on the log_entry payload
            for word in entry.log_entry.split():

                # increment the WordHash with the new key
                self.increment(word, word)

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
