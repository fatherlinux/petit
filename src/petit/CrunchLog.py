"""
Generic log class which contains a payload of objects which conform to the
LogEntry specification.  Log, which is a List (array) of type LogEntry,  is
relied upon and consumed to build any of the XHash objects such as SuperHash
or GraphHash.
"""

from __future__ import annotations

import datetime
import io
import logging
import re
import sys
import time
from collections import UserList

from .errors import DataFileError, EmptyLogError, ParseError

# Bound on how many times select() will resample before giving up and
# using RawEntry. Without a bound, input that no driver claims spins forever.
MAX_SELECT_ROUNDS = 5

# Lines drawn per selection round. Each further round widens the sample.
SAMPLE_LINES_PER_ROUND = 10


def sample_indices(total: int, count: int) -> list[int]:
    """Evenly spaced line numbers across a buffer of `total` lines.

    Deterministic by construction. Selection used to draw with
    random.choice(), which made the driver — and therefore the entire
    output — a function of the RNG as well as the input: the same bytes
    could come back parsed two different ways, or parse cleanly on one call
    and fail on the next. Anything that caches on petit's output, diffs two
    runs, or simply expects a log tool to be reproducible could not rely on
    it.

    Spreading the sample evenly is also better evidence than drawing at
    random, because it is guaranteed to look at the head and the tail. A
    buffer whose format changes half way through is a real shape, and random
    draws can miss it entirely.
    """
    if count >= total:
        return list(range(total))
    step = total / count
    return [int(i * step) for i in range(count)]


def split_lines(text: str) -> list[str]:
    """Break `text` into lines the way reading a file in text mode does.

    Universal newlines: `\\r\\n` and `\\r` become `\\n`, and nothing else
    ends a line. The one splitter every input goes through.
    """
    return io.StringIO(text, newline=None).readlines()


def read_source(filename: str) -> str:
    """Text of `filename`, or of stdin when it is "__none__".

    A missing or unreadable file is an ordinary operator mistake, not a bug,
    and it should read like one. Left bare it escapes as a PermissionError
    traceback (reported as issue #16), and bytes that are not text escape
    as a UnicodeDecodeError.
    """
    if filename == "__none__":
        return sys.stdin.read()
    logging.debug("Opening File: %s", filename)
    try:
        with open(filename) as handle:
            return handle.read()
    except OSError as exc:
        raise DataFileError(f"cannot read {filename}: {exc.strerror or exc}") from exc
    except UnicodeDecodeError as exc:
        raise DataFileError(f"cannot read {filename}: not valid text ({exc.reason})") from exc


class Tally:

    def __init__(self, entry_types: list[type[LogEntry]], max_sample_lines: int) -> None:
        self.matrix: dict[type[LogEntry], int] = {}
        self.max_sample_lines = max_sample_lines
        self.tally_threshold = max_sample_lines / 4

        for entry_type in entry_types:
            self.matrix[entry_type] = 0

    def append(self, entry_type: type[LogEntry]) -> None:
        self.matrix[entry_type] += 1

    def is_type(self, entry_type: type[LogEntry]) -> bool:

        # Setup the correct tally logic method
        tally_logic = entry_type.tally_logic

        m = self.matrix[entry_type]
        th = self.tally_threshold
        msl = self.max_sample_lines

        return tally_logic(m, th, msl)


class CrunchLog(UserList["LogEntry"]):
    """
    Class which extends UserList to provide robust in memory log object
    """

    # True when the detected driver could not parse the whole buffer and
    # RawEntry was used instead, so grouping is structural only.
    degraded = False

    Entry: type[LogEntry]
    payload_type: str
    file_name: str
    build_date: datetime.datetime

    def __init__(self, filename: str = "") -> None:
        UserList.__init__(self)

        if filename == "":
            return

        # A file is read to text and then parsed exactly as from_text() parses
        # a string. There used to be two entry points into the parser — this
        # one split with readlines(), from_text with str.splitlines(), which
        # also breaks on form feeds and U+2028 — so the CLI and the library
        # could disagree about where a line ended in the same bytes.
        self._build(split_lines(read_source(filename)), filename)

    @classmethod
    def from_text(
        cls,
        text: str,
        source_name: str = "<text>",
        driver: type[LogEntry] | None = None,
        strict: bool = False,
    ) -> CrunchLog:
        """Build a log from a string already in memory.

        The reason this exists: every caller that is not a shell has its
        payload in memory already, and the file-only constructor forced it
        through a temporary file to use this library at all.

        `driver` pins the entry class instead of detecting one. `strict`
        restores the old behaviour of raising when the driver meets a line
        it cannot parse, rather than falling back to RawEntry.
        """
        log = cls()
        log._build(split_lines(text), source_name, driver=driver, strict=strict)
        return log

    def _parse(
        self, buf: list[str], entry_type: type[LogEntry]
    ) -> tuple[list[LogEntry] | None, tuple[int, str] | None]:
        """Parse every line with `entry_type`.

        Returns (entries, None) on success, or (None, (line_number, line))
        for the first line the driver could not handle.
        """
        entries = []
        for counter, line in enumerate(buf):
            try:
                entry = entry_type(line)
            except (ValueError, TypeError, IndexError):
                return None, (counter, line)
            # Keep the line exactly as it arrived. Every driver normalises
            # while parsing — collapsing runs of whitespace, substituting
            # placeholder dates for formats that carry none — so the parsed
            # fields cannot reconstruct the original. A caller that wants to
            # show a human what was actually in the log needs the bytes.
            entry.raw = line.rstrip("\n")
            entry.line_number = counter
            entries.append(entry)
        return entries, None

    def _build(
        self,
        buf: list[str],
        source_name: str,
        driver: type[LogEntry] | None = None,
        strict: bool = False,
    ) -> None:
        """Select a driver for the buffer and parse every line with it."""
        if len(buf) < 1:
            raise EmptyLogError("no data found in " + (source_name or "input"))

        # Automatically select entry type
        self.Entry = driver if driver is not None else self.select(buf)
        self.degraded = False

        entries, failure = self._parse(buf, self.Entry)

        if entries is None:
            # _parse's contract: None entries implies a failure tuple.
            if failure is None:  # pragma: no cover
                raise RuntimeError("unreachable: _parse reported no entries and no failure")
            # The driver was chosen from a sample and then applied to every
            # line, so one line in a different shape used to abort the whole
            # run. That is not an exotic input: application logs interleave
            # stack traces, and tool output mixes JSON with prose. Dying on
            # line 400 of 401 serves nobody.
            #
            # Fall back to RawEntry, which parses anything, and record that
            # the grouping is structural rather than format-aware so the
            # caller can say so. `strict` keeps the old behaviour for callers
            # that would rather hear about it.
            if strict or self.Entry is RawEntry:
                raise ParseError(*failure)
            logging.info("%s could not parse line %d; falling back to RawEntry",
                         self.Entry.__name__, failure[0])
            self.Entry = RawEntry
            self.degraded = True
            entries, failure = self._parse(buf, self.Entry)
            if entries is None:  # pragma: no cover - RawEntry accepts anything
                if failure is None:
                    raise RuntimeError("unreachable: _parse reported no entries and no failure")
                raise ParseError(*failure)

        self.data = entries

        # Save for introspective purpose
        self.payload_type = self.Entry.__name__
        self.file_name = source_name
        self.build_date = datetime.datetime.now()

    def select(self, buf: list[str]) -> type[LogEntry]:
        """
        Determines which type of entry to use when building CrunchLog by
        by sampling the buffer and using a quarum based on votes for each
        log type
        """

        if len(buf) < 1:
            return RawEntry

        # This loop used to be `while (1)`, which never terminated when no
        # driver reached quorum — and sample_lines grew on every pass, so it
        # burned memory while it span. A buffer of blank lines does exactly
        # that: an empty split() yields [], and every is_type() rejects an
        # empty list, RawEntry's included, so nothing ever votes.
        #
        # Resampling more than a few times means the buffer is not giving a
        # clear answer, and more rounds will not change that. Cap it and fall
        # back to RawEntry, which is what the registry already appoints as the
        # last resort.
        for round_number in range(1, MAX_SELECT_ROUNDS + 1):

            # Widen the sample each round rather than accumulating votes on
            # top of the previous round's. The old code reused one Tally and
            # re-counted every line it had ever sampled, so round three
            # weighed the first ten lines three times over.
            wanted = SAMPLE_LINES_PER_ROUND * round_number
            indices = sample_indices(len(buf), wanted)
            sample_lines = [buf[i].split() for i in indices]

            # Quorum is judged against the lines actually drawn, not the
            # number requested, so a log shorter than the sample size can
            # still satisfy a driver that demands unanimity.
            t = Tally(entry_types, len(sample_lines))

            # Build tallies for the collected samples
            for line in sample_lines:
                for entry_type in entry_types:
                    if entry_type.is_type(line):
                        t.append(entry_type)
                        break

            # Tally logic is determined by driver
            for entry_type in entry_types:
                if t.is_type(entry_type):
                    logging.info("Determined %s: %s", entry_type.__name__, t.matrix[entry_type])

                    return entry_type

            # Already looked at every line; another round sees the same data.
            if len(indices) >= len(buf):
                break

        logging.info("No driver reached quorum after %d rounds; using RawEntry",
                     MAX_SELECT_ROUNDS)
        return RawEntry

    def contains(self, obj: type[LogEntry]) -> bool:
        """Determine what kind of objects are contained in this Log"""
        if len(self) >= 1:
            return isinstance(self[len(self) - 1], obj)
        return False

    def display(self) -> None:
        """Simple display function to show entire log"""
        for entry in self:
            entry.display()

    def subset(self, string: str) -> CrunchLog:
        """Return Log object with subset of entries based on a filter"""

        newlog = CrunchLog()
        for entry in self:
            if re.search(string, entry.log_entry):
                newlog.append(entry)

        return newlog


class LogEntry:
    """Interface class which specifies generic log format for consumption
    by other classes"""
    year = ""
    month = ""
    day = ""
    hour = ""
    minute = ""
    second = ""
    host = ""
    daemon = ""
    log_entry = ""
    # The line exactly as it arrived, set by CrunchLog._parse. Parsing is
    # lossy in every driver, so this is the only faithful copy.
    raw = ""
    # 0-based position in the source buffer, set by CrunchLog._parse.
    # Grouping reorders by definition; this is how a caller gets back to
    # where a line actually was.
    line_number = -1

    def __init__(self, line: str) -> None:
        """Every concrete driver parses `line` in its own __init__."""

    @staticmethod
    def is_type(line: list[str]) -> bool:
        """Every concrete driver decides whether it claims `line`."""
        raise NotImplementedError

    def display(self) -> None:
        print("Year: ", self.year,
              "Month:", self.month,
              "Day:", self.day,
              "Hour:", self.hour,
              "Minute:", self.minute,
              "Second:", self.second,
              "Host:", self.host,
              "Payload", self.log_entry)

    @staticmethod
    def tally_logic(tally: int, tally_threshold: float, _max_sample_lines: int) -> bool:
        return tally > tally_threshold

    def set_abnormal(self, value: list[str]) -> None:
        (self.year, self.month, self.day, self.hour, self.minute, self.second,
         self.host, self.daemon) = ["1900", "01", "01", "01", "01", "01", "#", "#"]
        self.log_entry = ' '.join(value)

    def set_blank(self) -> None:
        (self.year, self.month, self.day, self.hour, self.minute, self.second,
         self.host, self.daemon) = ["1900", "01", "01", "01", "01", "01", "#", "#"]
        self.log_entry = "#"


class SyslogEntry(LogEntry):
    """Driver for Syslog. Conforms to LogEntry interface class."""

    def __init__(self, line: str) -> None:

        # Split the line up
        value = line.split()

        # Should be normal log entry
        if len(value) >= 5:

            # Syslog does not store year information so, set to current year
            self.year = str(datetime.date.today().year)
            self.month, self.day, clocktime, self.host, self.daemon = value[:5]
            self.log_entry = ' '.join(value[5:])
            self.hour, self.minute, self.second = clocktime.split(":")

            # Convert month to integer
            self.month = str(time.strptime(self.month, "%b")[1])

            # Normalize integers to standard widths and convert to strings
            self.year = f"{int(self.year):04d}"
            self.month = f"{int(self.month):02d}"
            self.day = f"{int(self.day):02d}"
            self.hour = f"{int(self.hour):02d}"
            self.minute = f"{int(self.minute):02d}"
            self.second = f"{int(self.second):02d}"

        # Abnormal log entry
        elif len(value) >= 1:
            self.set_abnormal(value)

        # Blank line, will be sorted out by scrub
        else:
            self.set_blank()

    @staticmethod
    def is_type(line: list[str]) -> bool:
        """Standard function from interface class to determine type"""

        if len(line) < 6:
            return False

        # Look for something similar to: "Feb 29 11:53:08" in first
        # three columns
        return bool(
            re.search("[A-Z][a-z]{2}", line[0])
            and re.search("[0-9][0-9]?", line[1])
            and re.search("[0-9{2}:[0-9]{2}:[0-9]{2}", line[2])
            and not (re.search("^pam_", line[5]) or re.search(r"^sshd\[", line[4]))
        )


class RSyslogEntry(LogEntry):
    """Driver for RSyslog. Conforms to LogEntry interface class."""

    def __init__(self, line: str) -> None:

        # Split the line up
        value = line.split()

        # Should be normal log entry
        if len(value) >= 5:

            # Complete major splits: 2010-06-24T17:56:32.197716-04:00
            date, rtime = value[0].split("T")  # Raw time

            # High precision time with timezone info: 17:56:32.197716-04:00
            hptime, _offset = rtime.split("-")

            # Patch for mixed enviornments, milliseconds do not get logged
            # if older Ubuntu 8.04 boxes log to a newer 10.04 server with
            # Rsyslog precision time on.
            if re.search(r"[0-9]{2}:[0-9]{2}:[0-9]{2}\.[0-9]{6}", hptime):
                clocktime, _mseconds = hptime.split(".")  # Miliseconds
            else:
                clocktime = hptime

            # Complete secondary splits
            self.year, self.month, self.day = date.split("-")
            self.hour, self.minute, self.second = clocktime.split(":")
            self.host = value[1]
            self.daemon = value[2]
            self.log_entry = ' '.join(value[3:])

            # Normalize integers to standard widths and convert to strings
            self.year = f"{int(self.year):04d}"
            self.month = f"{int(self.month):02d}"
            self.day = f"{int(self.day):02d}"
            self.hour = f"{int(self.hour):02d}"
            self.minute = f"{int(self.minute):02d}"
            self.second = f"{int(self.second):02d}"

        # Abnormal log entry
        elif len(value) >= 1:
            self.set_abnormal(value)

        # Blank line, will be sorted out by scrub
        else:
            self.set_blank()

    @staticmethod
    def is_type(line: list[str]) -> bool:
        """Standard function from interface class to determine type"""

        if len(line) < 1:
            return False

        # Look for something similar to: "2011-04-04T"
        return bool(re.search("[0-9]{4}-[0-9]{2}-[0-9]{2}T", line[0]))


class ApacheAccessEntry(LogEntry):
    """Driver for Apache Access formatted log files"""

    # Whitespace-separated fields in the Apache combined log format.
    FIELD_COUNT = 12

    def __init__(self, line: str) -> None:

        # Split the line up
        value = line.split()

        # Should be normal log entry
        if len(value) >= self.FIELD_COUNT:
            # Grab major chunks from the line
            (_rhost, _ident, _ruser, apachedate, _junk, _junk2, uri, _protocol,
             _status, _size, _referer, _agent) = value[:self.FIELD_COUNT]
            self.log_entry = uri

            # Split up something that looks like this: [03/Aug/2009:11:53:08
            entry_datetime = apachedate.split(':')
            date = entry_datetime[0]
            self.hour = entry_datetime[1]
            self.minute = entry_datetime[2]
            self.second = entry_datetime[3]
            dmy = date.split('/')
            self.day = re.sub(r"\[", "", dmy[0])
            self.month = dmy[1]
            self.year = dmy[2]
            self.host = uri

            # Convert month to integer
            self.month = str(time.strptime(self.month, "%b")[1])

            # Normalize integers to standard widths and convert to strings
            self.year = f"{int(self.year):04d}"
            self.month = f"{int(self.month):02d}"
            self.day = f"{int(self.day):02d}"
            self.hour = f"{int(self.hour):02d}"
            self.minute = f"{int(self.minute):02d}"
            self.second = f"{int(self.second):02d}"

        # Abnormal log entry
        elif len(value) >= 1:
            self.set_abnormal(value)

        # Blank line, will be sorted out by scrub
        else:
            self.set_blank()

    @staticmethod
    def is_type(line: list[str]) -> bool:
        """Standard function from interface class to determine type"""

        if len(line) < 4:
            return False

        # Look for: "03/Aug/2009:11:53:08" in forth column
        r = "[0-9]{2}/[a-zA-Z]{3}/[0-9]{4}:[0-9{2}:[0-9]{2}:[0-9]{2}"
        return bool(re.search(r, line[3]))


class ApacheErrorEntry(LogEntry):
    """Driver for Apache Error formatted log files"""

    def __init__(self, line: str) -> None:

        # Split the line up
        value = line.split()

        # Should be normal log entry
        if len(value) >= 5:
            # Grab major chunks from the line
            # Split up something that looks like this:
            # [Sat Feb 27 12:16:10 2010]
            _junk, self.month, self.day, clocktime, self.year = value[:5]
            self.log_entry = ' '.join(value[5:])
            self.hour, self.minute, self.second = clocktime.split(":")

            # Convert month to integer
            self.month = str(time.strptime(self.month, "%b")[1])

            # Clean up the year field
            self.year = re.sub(r"\]", "", self.year)

            # Normalize integers to standard widths and convert to strings
            self.year = f"{int(self.year):04d}"
            self.month = f"{int(self.month):02d}"
            self.day = f"{int(self.day):02d}"
            self.hour = f"{int(self.hour):02d}"
            self.minute = f"{int(self.minute):02d}"
            self.second = f"{int(self.second):02d}"

        # Abnormal log entry
        elif len(value) >= 1:
            self.set_abnormal(value)

        # Blank line, will be sorted out by scrub
        else:
            self.set_blank()

    @staticmethod
    def is_type(line: list[str]) -> bool:
        """Standard function from interface class to determine type"""

        if len(line) < 5:
            return False

        # Look for : [Sat Feb 27 12:16:10 2010]
        return bool(
            re.search(r"[\[a-zA-Z]{3}", line[0])
            and re.search("[0-9]{2}:[0-9]{2}:[0-9]{2}", line[3])
            and re.search("[0-9]{4}", line[4])
        )


class SecureLogEntry(LogEntry):
    """Driver for Syslog. Conforms to LogEntry interface class."""

    def __init__(self, line: str) -> None:

        # Split the line up
        value = line.split()

        # Should be normal log entry
        if len(value) >= 5:
            # Syslog does not store year information so, set to current year
            self.year = str(datetime.date.today().year)
            self.month, self.day, clocktime, self.host, self.daemon = value[:5]
            self.log_entry = ' '.join(value[5:])
            self.hour, self.minute, self.second = clocktime.split(":")

            # Convert month to integer
            self.month = str(time.strptime(self.month, "%b")[1])

            # Normalize integers to standard widths
            self.year = f"{int(self.year):04d}"
            self.month = f"{int(self.month):02d}"
            self.day = f"{int(self.day):02d}"
            self.hour = f"{int(self.hour):02d}"
            self.minute = f"{int(self.minute):02d}"
            self.second = f"{int(self.second):02d}"

        # Abnormal log entry
        elif len(value) >= 1:
            self.set_abnormal(value)

        # Blank line, will be sorted out by scrub
        else:
            self.set_blank()

    @staticmethod
    def is_type(line: list[str]) -> bool:
        """Standard function from interface class to determine type"""

        if len(line) < 6:
            return False

        # Look for something similar to: "29 11:53:08" in third column
        return bool(
            re.search("[0-9][0-9]?", line[1])
            and re.search("[0-9{2}:[0-9]{2}:[0-9]{2}", line[2])
            and (re.search("^pam_", line[5]) or re.search(r"^sshd\[", line[4]))
        )

    @staticmethod
    def tally_logic(tally: int, _tally_threshold: float, max_sample_lines: int) -> bool:
        """Override tally logic for secure logs"""

        return tally >= max_sample_lines


class RawEntry(LogEntry):
    """
    Driver for Raw log files. Conforms to LogEntry interface class.
    This also allows raw logs to contain all of the correct fields
    to be worked with just like other entries that actually have time
    values
    """

    def __init__(self, line: str) -> None:

        # Split the line up
        value = line.split()

        # Fake the time/date values, put the entire line in the key
        if len(value) >= 1:
            self.set_abnormal(value)

        # Blank line, will be sorted out by scrub
        else:
            self.set_blank()

    @staticmethod
    def is_type(line: list[str]) -> bool:
        """
        Do minimum checking to ensure there is some data
        """

        if len(line) < 1:
            return False

        # Look for any length of text in the line
        return bool(re.search(".+", str(line)))


class SnortEntry(LogEntry):
    """
    Driver for Snort formatted log files. Conforms to LogEntry interface class.
    """

    def __init__(self, line: str) -> None:

        # Split the line up
        value = line.split()

        # Should be normal log entry
        if len(value) >= 2:

            # Snort does not store year information so, set to current year
            self.year = str(datetime.date.today().year)

            # Initial break down
            snortdate_parts = value[:1]
            self.log_entry = ' '.join(value[1:])

            # Looks like "09/29-10:18:46.026172"
            snortdate, _junk = snortdate_parts[0].split('.')

            # Looks like "09/29-10:18:46"
            self.month, snortdate = snortdate.split('/')

            # Looks like "29-10:18:46"
            self.day, snortdate = snortdate.split('-')

            # Looks like "10:18:46"
            self.hour, self.minute, self.second = snortdate.split(':')

            # Normalize integers to standard widths and convert to strings
            self.year = f"{int(self.year):04d}"
            self.month = f"{int(self.month):02d}"
            self.day = f"{int(self.day):02d}"
            self.hour = f"{int(self.hour):02d}"
            self.minute = f"{int(self.minute):02d}"
            self.second = f"{int(self.second):02d}"

        # Abnormal value
        elif len(value) >= 1:
            self.set_abnormal(value)

        # Blank line, will be sorted out by scrub
        else:
            self.set_blank()

    @staticmethod
    def is_type(line: list[str]) -> bool:

        if len(line) < 4:
            return False

        # Look for : "09/29-10:18:46.026172" in first column
        r = r"[0-9]{2}\/[0-9]{2}\-[0-9]{2}\:[0-9]{2}\:[0-9]{2}\.[0-9]{6}"
        return bool(re.search(r, line[0]))


# Automatically load a list of drivers for each file type this will be used
# to determine what kind of log it is. Do NOT append the parent LogEntry and
# append RawEntry to the end to preserve last resort logic
_module_attrs: dict[str, object] = sys.modules[__name__].__dict__
entry_types: list[type[LogEntry]] = []

for _name in list(_module_attrs.keys()):
    _candidate = _module_attrs[_name]
    if isinstance(_candidate, type) and issubclass(_candidate, LogEntry) \
            and _candidate is not LogEntry and _candidate is not RawEntry:
        entry_types.append(_candidate)

entry_types.append(RawEntry)
