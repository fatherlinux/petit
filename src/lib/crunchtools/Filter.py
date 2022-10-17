"""Defines filter class for use with SuperHash"""

import logging
import os
import re
import sys


class Filter:
    """Filter object used to load filters into memory once, to save on file operations"""

    global logging

    file = ""
    prefixes = [
        "/var/lib/petit/filters/",
        "/usr/local/petit/var/lib/filters/",
        "/opt/petit/var/lib/filters/",
    ]

    stopwords = []

    def __init__(self, file="__none__"):

        global logging

        for prefix in self.prefixes:

            # Set class variable to file & path
            self.file = prefix + file
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

                except OSError:
                    print("Could not open Filter file", self.file)
                    sys.exit(16)

        logging.info("Filter File: " + str(self.file))

    def scrub(self, string):
        """Used to remove entries and replace them with the scrub character"""

        global logging

        # Check each stopword against each key
        for stopword in self.stopwords:

            # Replace mathces with hash signs
            old_string = string
            string = re.sub(stopword, "#", string)
            logging.debug(
                " SCRUBBING "
                + old_string
                + " OF "
                + stopword.pattern
                + " BECOMES "
                + string
            )

        return string

    def bleach(self, string):
        """Determine if a scrub has or should happen"""

        if self.scrub(string) == "#":
            return True
        else:
            return False
