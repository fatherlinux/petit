"""Framing: turning a buffer of lines into records before any driver sees it.

petit used to assume one line is one entry. A JSON array element or an email
in a thread is not a line, so framing is its own stage, run before driver
selection. A framer looks at the whole buffer, says whether it claims it,
and cuts it into Records. Every entry driver still receives a string —
`record.text` — so a one-line record is byte-identical to the line every
driver has always been given.

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
framers: list[type[Framer]] = [JsonFramer, MessageFramer, LineFramer]
FRAMER_NAMES = ("auto", *(framer.name for framer in framers))
