"""Library entry points — petit's analysis without petit's command line.

Everything here takes text already in memory, returns data, and raises on
failure. No file paths, no stdout, no sys.exit. The CLI is one caller of this
module; a service embedding petit is another, and neither should have to
route a payload through a temporary file or lose its process to a bad line.

    from crunchtools.api import hash_text

    for group in hash_text(open("/var/log/messages").read()):
        print(group.count, group.pattern)

Driver selection is unchanged: `CrunchLog` samples the buffer, each registered
driver votes, and the winner parses every line. Adding a driver to
`CrunchLog` makes it available here automatically.
"""

from __future__ import annotations

from dataclasses import dataclass, field

from .CrunchLog import CrunchLog
from .LogHash import SuperHash


@dataclass(frozen=True)
class Group:
    """One set of lines that share a fingerprint.

    `pattern` is the fingerprint the driver produced — the line with its
    volatile tokens normalised.

    `samples` are members of the group, rendered from the fields the driver
    parsed. They are NOT guaranteed verbatim: some hash drivers (SecureLogHash
    is one) rewrite `log_entry` in place while fingerprinting, so a sample can
    come back already generalised. What a sample reliably preserves is the
    envelope — timestamp, host, daemon — which is usually the part you wanted
    a sample for.
    """

    pattern: str
    count: int
    samples: list[str] = field(default_factory=list)


def _render(entry) -> str:
    """Rebuild a readable line from a parsed entry.

    LogEntry has no __str__, so the alternative is an object repr, which is
    useless to a caller and worse than useless in a log.
    """
    parts = []
    for attr in ("month", "day"):
        value = getattr(entry, attr, None)
        if value:
            parts.append(str(value))
    clock = ":".join(
        str(getattr(entry, a))
        for a in ("hour", "minute", "second")
        if getattr(entry, a, None)
    )
    if clock:
        parts.append(clock)
    for attr in ("host", "daemon"):
        value = getattr(entry, attr, None)
        if value and not isinstance(value, list):
            parts.append(str(value))
    payload = getattr(entry, "log_entry", None)
    if payload:
        parts.append(str(payload))
    return " ".join(parts) if parts else repr(entry)


def hash_text(
    text: str,
    *,
    filter_name: str = "hash.stopwords",
    max_samples: int = 3,
    source_name: str = "<text>",
) -> list[Group]:
    """Group `text` by line fingerprint, most frequent first.

    Args:
        text: The log or payload to analyse.
        filter_name: Stopword file to apply, resolved from packaged data.
            Pass "__none__" for no filtering.
        max_samples: Real lines to retain per group.
        source_name: Label used in errors and logging.

    Returns:
        Groups sorted by descending count. An empty list only when `text`
        held nothing usable.

    Raises:
        EmptyLogError: `text` contained no data.
        ParseError: the selected driver could not parse a line.
        DataFileError: `filter_name` was given but could not be read.
    """
    log = CrunchLog.from_text(text, source_name=source_name)
    hashed = SuperHash.manufacture(log, filter_name)

    groups = [
        Group(
            pattern=str(key),
            count=value[0],
            samples=[_render(entry) for entry in value[1][:max_samples]],
        )
        for key, value in hashed.items()
    ]
    groups.sort(key=lambda g: (-g.count, g.pattern))
    return groups


def detect_format(text: str, source_name: str = "<text>") -> str:
    """Name of the driver that claims `text`, without parsing all of it.

    Useful to a caller deciding whether petit is the right tool at all: a
    "RawEntry" answer means no driver recognised the format, so grouping will
    be structural at best.
    """
    log = CrunchLog.from_text(text, source_name=source_name)
    return log.payload_type
