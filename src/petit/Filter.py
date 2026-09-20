"""Defines filter class for use with SuperHash"""

from __future__ import annotations

import logging
import os
import re

from .errors import DataFileError
from .resources import search_prefixes


class Filter:
    """Filter object used to load filters into memory once, to save on file operations"""

    file = ""
    # Packaged data first, legacy system paths after — see resources.py
    prefixes = search_prefixes("filters")

    # Not a ClassVar: every instance gets its own list, reassigned in
    # __init__/from_patterns before use. This is only the pre-assignment
    # type declaration.
    stopwords: list[tuple[re.Pattern[str], str]]

    @classmethod
    def from_patterns(cls, patterns: list[str | tuple[str, str]]) -> Filter:
        """Build a filter from regexes supplied by the caller.

        Normalisation policy belongs to whoever is reading the output. The
        packaged hash.stopwords is tuned for system logs and is deliberately
        aggressive — `[a-f]+#` collapses the letters next to a scrubbed
        number, so "bob0" and "boa0" land in the same group. That is the
        right trade for spotting a flapping daemon and the wrong one for a
        caller who needs two distinct names to stay distinct.

        Rather than have such a caller ship a file into a package data
        directory to be found by name, let it hand over the patterns.

        Each entry is either a regex, which is replaced with "#" as a file
        would be, or a (regex, replacement) pair. Distinct replacements keep
        a fingerprint legible: "<TS> host sshd[<N>]: login from <IP>" says
        what was normalised away, where "# host sshd[#]: login from #" only
        says that something was.
        """
        instance = cls.__new__(cls)
        instance.file = "<patterns>"
        instance.stopwords = [
            (re.compile(p), "#") if isinstance(p, str)
            else (re.compile(p[0]), p[1])
            for p in patterns
        ]
        return instance

    def __init__(self, file: str = "__none__") -> None:
        for prefix in self.prefixes:

            # Set class variable to file & path
            self.file = prefix + file
            self.stopwords = []

            if file == "__none__":
                return

            # Open the file and get each stopword or regex
            if os.path.exists(self.file):
                try:
                    with open(self.file) as f:
                        for line in f.readlines():

                            # Read entire contents into array for speed
                            # Save them as compiled regexes for speed
                            # Patterns from a file have no replacement of
                            # their own; "#" is the scrub character petit has
                            # always used.
                            self.stopwords.append((re.compile(line.rstrip()), "#"))
                    break

                except OSError as exc:
                    raise DataFileError(
                        "could not open filter file " + str(self.file)
                    ) from exc

        logging.info("Filter File: " + str(self.file))

    def scrub(self, string: str) -> str:
        """Used to remove entries and replace them with the scrub character"""

        # Check each stopword against each key
        for stopword, replacement in self.stopwords:

            # Replace matches with this pattern's replacement
            old_string = string
            string = stopword.sub(replacement, string)
            logging.debug(
                " SCRUBBING %s OF %s BECOMES %s", old_string, stopword.pattern, string
            )

        return string

    def bleach(self, string: str) -> bool:
        """Determine if a scrub has or should happen"""

        return self.scrub(string) == "#"
