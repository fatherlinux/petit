"""Framing: turning a buffer of lines into records before any driver sees it.

petit used to assume one line is one entry. A JSON array element, an email
in a thread, or a log message with a stack trace under it is not a line, so
framing is its own stage, run before driver selection. A framer looks at
the whole buffer, says whether it claims it, and cuts it into Records.
Every entry driver still receives a string — `record.text` — so a one-line
record is byte-identical to the line every driver has always been given.

Framers are tried in the order of `framers`; LineFramer is last and always
claims, mirroring how RawEntry closes the entry-driver registry.

Everything here reads attacker-controlled text. Claims decline rather than
raise, sizes are capped before parsing, and every regex is linear: character
classes and bounded repetition, no nested quantifiers.
"""

from __future__ import annotations

import json
import re
from bisect import bisect_right
from dataclasses import dataclass
from itertools import pairwise
from typing import Any, ClassVar

# JsonFramer declines a buffer larger than this rather than parse it.
MAX_JSON_CHARS = 4_000_000

# JsonFramer declines JSON nested deeper than this. json.loads recurses, and
# so does anything that walks the result.
MAX_JSON_DEPTH = 64

# A JSON string literal, escapes included. The alternatives are disjoint on
# their first character, so matching is linear.
_JSON_STRING = re.compile(r'"(?:[^"\\]|\\.)*"')
_JSON_BRACKET = re.compile(r"[\[\]{}]")


def _skip_whitespace(text: str, idx: int) -> int:
    while idx < len(text) and text[idx].isspace():
        idx += 1
    return idx


@dataclass(frozen=True)
class Record:
    """One unit of input: a line, a JSON object, a message.

    `start` and `end` are 0-based source line numbers, `end` exclusive.
    `lines` hold the record's own text, which for a JSON element on a line
    shared with others is just that element.
    """

    lines: list[str]
    start: int
    end: int

    @property
    def text(self) -> str:
        return "".join(self.lines)


def json_depth_ok(text: str, limit: int = MAX_JSON_DEPTH) -> bool:
    """False when brackets in `text` nest deeper than `limit`.

    Brackets inside string literals don't count. Linear in `text`.
    """
    depth = 0
    for bracket in _JSON_BRACKET.findall(_JSON_STRING.sub("", text)):
        if bracket in "[{":
            depth += 1
            if depth > limit:
                return False
        else:
            depth -= 1
    return True


def parse_json_object(text: str) -> dict[str, Any]:
    """Parse `text` as one JSON object, or raise ValueError.

    Oversized or over-deep input is refused before json.loads sees it, so
    the only exception a caller has to expect is ValueError.
    """
    if len(text) > MAX_JSON_CHARS or not json_depth_ok(text):
        raise ValueError("JSON too large or too deeply nested")
    value = json.loads(text)
    if not isinstance(value, dict):
        raise ValueError("not a JSON object")
    return value


def _loads_or_none(text: str) -> Any:
    try:
        return json.loads(text)
    except ValueError:
        return None


class Framer:
    """Interface: decide whether a buffer is yours, then cut it into records."""

    name: ClassVar[str] = ""
    # Entry driver every record from this framer is parsed with, by name,
    # instead of voting. None lets the drivers vote as they always have.
    entry_name: ClassVar[str | None] = None

    @staticmethod
    def claims(buf: list[str]) -> bool:
        raise NotImplementedError

    @staticmethod
    def frame(buf: list[str]) -> list[Record]:
        raise NotImplementedError


class JsonFramer(Framer):
    """A JSON array of objects, or JSON Lines: one object per record."""

    name = "json"
    entry_name = "StructuredEntry"

    @staticmethod
    def claims(buf: list[str]) -> bool:
        text = "".join(buf)
        if len(text) > MAX_JSON_CHARS:
            return False
        stripped = text.strip()
        if not stripped or stripped[0] not in "[{" or not json_depth_ok(stripped):
            return False
        if stripped[0] == "[":
            value = _loads_or_none(stripped)
            return isinstance(value, list) and bool(value) \
                and all(isinstance(item, dict) for item in value)
        return all(isinstance(_loads_or_none(line), dict) for line in buf if line.strip())

    @staticmethod
    def frame(buf: list[str]) -> list[Record]:
        text = "".join(buf)
        if text.lstrip()[:1] == "[":
            return JsonFramer._frame_array(text)
        return [Record([line], i, i + 1) for i, line in enumerate(buf) if line.strip()]

    @staticmethod
    def _frame_array(text: str) -> list[Record]:
        """One record per array element, spanning the lines it sits on."""
        line_starts = [0]
        for match in re.finditer("\n", text):
            line_starts.append(match.end())

        decoder = json.JSONDecoder()
        records = []
        idx = _skip_whitespace(text, 0) + 1
        while True:
            idx = _skip_whitespace(text, idx)
            if text[idx] == "]":
                break
            _value, end = decoder.raw_decode(text, idx)
            first = bisect_right(line_starts, idx) - 1
            last = bisect_right(line_starts, end - 1) - 1
            records.append(Record(text[idx:end].splitlines(keepends=True), first, last + 1))
            idx = _skip_whitespace(text, end)
            if text[idx] != ",":
                break
            idx += 1
        return records


# A header field: a name of printable characters other than colon, then a
# colon. RFC 5322 section 2.2.
HEADER_FIELD = re.compile(r"([!-9;-~]{1,76}):")

# A header block must name at least one of these to count as a message.
_MESSAGE_HEADERS = frozenset({
    "from", "to", "cc", "subject", "date", "message-id", "received",
    "reply-to", "in-reply-to", "references", "return-path", "mime-version",
})


def _header_block_at(buf: list[str], i: int) -> bool:
    """True when two or more header fields, one of them a mail header, start at line i."""
    fields = 0
    known = False
    for j in range(i, len(buf)):
        line = buf[j]
        match = HEADER_FIELD.match(line)
        if match:
            fields += 1
            known = known or match.group(1).lower() in _MESSAGE_HEADERS
        elif not (fields and line[:1] in (" ", "\t")):
            break
    return fields >= 2 and known


def _message_starts(buf: list[str]) -> list[int]:
    """Line numbers where a message begins.

    An mbox `From ` separator at the start of the buffer or after a blank
    line, if there are at least two; otherwise a header block in the same
    positions.
    """
    at_boundary = [
        i for i in range(len(buf)) if i == 0 or not buf[i - 1].strip()
    ]
    mbox = [i for i in at_boundary if buf[i].startswith("From ")]
    if len(mbox) >= 2:
        return mbox
    return [i for i in at_boundary if _header_block_at(buf, i)]


class MessageFramer(Framer):
    """RFC 822 messages: a mail thread or an mbox."""

    name = "message"
    entry_name = "EmailEntry"

    @staticmethod
    def claims(buf: list[str]) -> bool:
        return len(_message_starts(buf)) >= 2

    @staticmethod
    def frame(buf: list[str]) -> list[Record]:
        starts = _message_starts(buf)
        if not starts or starts[0] != 0:
            starts = [0, *starts]
        bounds = [*starts, len(buf)]
        return [Record(buf[a:b], a, b) for a, b in pairwise(bounds)]


# A multi-line message may run to this many lines. MultilineFramer declines a
# buffer with a longer one rather than build it.
MAX_RECORD_LINES = 1000

# An optional syslog priority, `<34>`, and RFC 5424 version, `<34>1 `.
_PRI = r"(?:<[0-9]{1,3}>(?:[0-9]{1,2} )?)?"
_YMD = r"[0-9]{4}-[0-9]{2}-[0-9]{2}"
_HMS = r"[0-9]{2}:[0-9]{2}:[0-9]{2}"
_LEVEL = r"(?:TRACE|DEBUG|INFO|NOTICE|WARN|WARNING|ERROR|FATAL|CRITICAL|SEVERE)"

# Timestamps a log message can start with, matched at column 0. A record
# starts on a line that begins with one; see MultilineFramer. Every pattern
# is character classes and bounded repeats, so matching is linear.
HEAD_PATTERNS: dict[str, re.Pattern[str]] = {
    name: re.compile(pattern) for name, pattern in {
        # Sep 23 10:00:00 — syslog, secure, journalctl -o short / short-precise
        "bsd": _PRI + r"[A-Z][a-z]{2} [ 0-9][0-9] [0-9]{2}:[0-9]{2}:[0-9]{2}",
        # YYYY-MM-DDThh:mm:ss or YYYY-MM-DD hh:mm:ss — RFC 3339/5424, rsyslog,
        # journalctl -o short-iso, Python logging, log4j, Go, Postgres
        "iso": _PRI + _YMD + "[T ]" + _HMS,
        # [YYYY-MM-DD hh:mm:ss — Elasticsearch and many application logs
        "iso_bracket": r"\[" + _YMD + "[T ]" + _HMS,
        # ERROR YYYY-MM-DD hh:mm or [INFO] YYYY-MM-DD hh:mm — level first
        "level_iso": r"\[?" + _LEVEL + r"\]?:? {1,8}\[?" + _YMD + r"[T ][0-9]{2}:[0-9]{2}",
        # YYYY/MM/DD hh:mm:ss — nginx error log, Go's log package
        "slash": r"[0-9]{4}/[0-9]{2}/[0-9]{2} [0-9]{2}:[0-9]{2}:[0-9]{2}",
        # [Sun Apr 10 04:04:00 — Apache error log
        "ctime_bracket": r"\[[A-Z][a-z]{2} [A-Z][a-z]{2} [ 0-9][0-9] [0-9]{2}:[0-9]{2}:[0-9]{2}",
        # host ident user [10/Apr/2011:04:04:00 — Apache/nginx access log
        "clf": r"[^ ]{1,255} [^ ]{1,255} [^ ]{1,255} \[[0-9]{2}/[A-Z][a-z]{2}/[0-9]{4}:" + _HMS,
        # 09/29-08:25:54 — Snort alerts
        "snort": r"[0-9]{2}/[0-9]{2}(?:/[0-9]{2})?-[0-9]{2}:[0-9]{2}:[0-9]{2}",
        # I0923 10:00:00.123456 — Kubernetes / glog
        "klog": r"[IWEF][0-9]{4} [0-9]{2}:[0-9]{2}:[0-9]{2}\.[0-9]{1,9}",
        # [ 1234.567890] — dmesg, journalctl -o short-monotonic
        "kernel": r"\[ {0,12}[0-9]{1,12}\.[0-9]{6}\]",
        # 1789845105.816 — Unix time: squid and some applications
        "epoch": r"[0-9]{10}(?:\.[0-9]{1,9})? ",
        # Mon DD, YYYY h:mm:ss AM — java.util.logging, older Tomcat
        "jul": r"[A-Z][a-z]{2} [0-9]{1,2}, [0-9]{4} [0-9]{1,2}:[0-9]{2}:[0-9]{2} [AP]M",
        # DD-Mon-YYYY hh:mm:ss — Tomcat 8 and later
        "tomcat": r"[0-9]{2}-[A-Z][a-z]{2}-[0-9]{4} [0-9]{2}:[0-9]{2}:[0-9]{2}",
        # MM/DD/YYYY hh:mm:ss — US-style dates
        "us_date": r"[0-9]{2}/[0-9]{2}/[0-9]{4} [0-9]{1,2}:[0-9]{2}:[0-9]{2}",
        # pid:role DD Mon YYYY hh:mm:ss — Redis
        "redis": r"[0-9]{1,10}:[XCSM] [0-9]{2} [A-Z][a-z]{2} [0-9]{4} [0-9]{2}:[0-9]{2}:[0-9]{2}",
        # 10:00:00.123 or 10:00:00,123 — logback's default layout
        "time_ms": r"[0-9]{2}:[0-9]{2}:[0-9]{2}[.,][0-9]{3}",
    }.items()
}


def _is_journald_marker(line: str) -> bool:
    """`-- Boot 3f2a... --`, `-- No entries --`: journalctl's own notes."""
    text = line.rstrip("\r\n")
    return text.startswith("-- ") and text.endswith(" --")


def _head_pattern(line: str) -> re.Pattern[str] | None:
    for pattern in HEAD_PATTERNS.values():
        if pattern.match(line):
            return pattern
    return None


def _multiline_bounds(buf: list[str]) -> list[tuple[int, int]] | None:
    """[start, end) line ranges of multi-line records, or None to decline.

    Decline unless the first line with content starts with a timestamp, at
    least one continuation line is indented, and no record runs past
    MAX_RECORD_LINES. Blank lines before the first record and journald
    markers belong to no record.
    """
    first = next((i for i, line in enumerate(buf)
                  if line.strip() and not _is_journald_marker(line)), None)
    if first is None:
        return None
    head = _head_pattern(buf[first])
    if head is None:
        return None

    bounds: list[tuple[int, int]] = []
    start = first
    indented = False
    for i in range(first + 1, len(buf)):
        line = buf[i]
        if _is_journald_marker(line) or head.match(line):
            bounds.append((start, i))
            start = i + 1 if _is_journald_marker(line) else i
        elif line[:1] in (" ", "\t") and line.strip():
            indented = True
        if i - start >= MAX_RECORD_LINES:
            return None
    bounds.append((start, len(buf)))
    if not indented:
        return None
    # A marker right before another boundary leaves an empty range.
    return [(a, b) for a, b in bounds if b > a]


class MultilineFramer(Framer):
    """Log messages that run over several lines: stack traces, tracebacks,
    journalctl's indented continuations.

    A record starts at a line that begins, in column 0, with a timestamp
    from HEAD_PATTERNS, and every line after it that doesn't is part of the
    same record. The timestamp format is fixed by the first record, so a
    continuation line that happens to start with a different kind of time
    stays a continuation.

    Only claims a buffer with at least one indented continuation line. A
    log without one frames line by line exactly as it always has.
    """

    name = "multiline"

    @staticmethod
    def claims(buf: list[str]) -> bool:
        return _multiline_bounds(buf) is not None

    @staticmethod
    def frame(buf: list[str]) -> list[Record]:
        bounds = _multiline_bounds(buf) or []
        return [Record(buf[a:b], a, b) for a, b in bounds]


class LineFramer(Framer):
    """One record per line. Claims any buffer with a line in it; the last resort."""

    name = "line"

    @staticmethod
    def claims(buf: list[str]) -> bool:
        return bool(buf)

    @staticmethod
    def frame(buf: list[str]) -> list[Record]:
        return [Record([line], i, i + 1) for i, line in enumerate(buf)]


# Tried in order. LineFramer must stay last.
framers: list[type[Framer]] = [JsonFramer, MessageFramer, MultilineFramer, LineFramer]
FRAMER_NAMES = ("auto", *(framer.name for framer in framers))
