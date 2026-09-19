"""Defines filter class for use with SuperHash"""

import os
import re
from .errors import DataFileError
from .resources import search_prefixes
import sys
import logging

class Filter:
    """Filter object used to load filters into memory once, to save on file operations"""

    global logging

    file = ""
    # Packaged data first, legacy system paths after — see resources.py
    prefixes = search_prefixes("filters")

    stopwords = []

    @classmethod
    def from_patterns(cls, patterns):
        """Build a filter from regexes supplied by the caller.

        Normalisation policy belongs to whoever is reading the output. The
        packaged hash.stopwords is tuned for system logs and is deliberately
        aggressive — `[a-f]+#` collapses the letters next to a scrubbed
        number, so "bob0" and "boa0" land in the same group. That is the
        right trade for spotting a flapping daemon and the wrong one for a
        caller who needs two distinct names to stay distinct.

        Rather than have such a caller ship a file into a package data
        directory to be found by name, let it hand over the patterns.
        """
        instance = cls.__new__(cls)
        instance.file = "<patterns>"
        instance.stopwords = [re.compile(p) for p in patterns]
        return instance

    def __init__(self, file="__none__"):

        global logging

        for prefix in self.prefixes:

            # Set class variable to file & path
            self.file = prefix+file
            self.stopwords = []

            if file == "__none__":
                return
        
            # Open the file and get each stopword or regex        
            if os.path.exists("%s" % self.file):
                try:
                    f = open(self.file)
                    for line in f.readlines():

                        # Read entire contents into array for speed
                        # Save them as compiled regexes for speed
                        self.stopwords.append(re.compile(line.rstrip()))
                    break

                except OSError as exc:
                    raise DataFileError(
                        "could not open filter file " + str(self.file)
                    ) from exc

        logging.info("Filter File: "+str(self.file))

    def scrub(self, string):
        """Used to remove entries and replace them with the scrub character"""

        global logging

        # Check each stopword against each key
        for stopword in self.stopwords:

            # Replace mathces with hash signs
            old_string = string
            string = re.sub(stopword, "#", string)
            logging.debug(" SCRUBBING "+old_string+" OF "+stopword.pattern+" BECOMES "+string)

        return string

    def bleach(self, string):
        """Determine if a scrub has or should happen"""
        
        if self.scrub(string) == "#":
            return True
        else:
            return False
