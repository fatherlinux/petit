"""Exceptions for the petit library.

The library used to call sys.exit() on bad input, which is defensible in a
command-line tool and fatal anywhere else: a caller embedding petit — a
service, a gateway, a test — loses its whole process to a malformed line.
Library code raises; only the CLI decides that an error ends the program.
"""


class PetitError(Exception):
    """Base for every error this library raises."""


class EmptyLogError(PetitError):
    """No usable data in the input."""


class ParseError(PetitError):
    """A line could not be parsed by the selected driver."""

    def __init__(self, line_number: int, line: str = "") -> None:
        self.line_number = line_number
        self.line = line
        super().__init__(f"cannot parse values on line {line_number}")


class DataFileError(PetitError):
    """A fingerprint or filter file could not be found or read."""
