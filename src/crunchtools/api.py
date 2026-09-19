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

from . import CrunchLog as _drivers
from .CrunchLog import CrunchLog
from .errors import PetitError
from .Filter import Filter
from .LogHash import SuperHash


@dataclass(frozen=True)
class Group:
    """One set of lines that share a fingerprint.

    `pattern` is the fingerprint the driver produced — the line with its
    volatile tokens normalised.

    `samples` are members of the group **exactly as they appeared in the
    input**, newline stripped. They used to be rebuilt from the parsed
    fields, which made them neither verbatim nor honest: SecureLogHash
    overwrote the payload while fingerprinting, so the user name or source
    address was already gone, and formats that carry no timestamp had one
    invented for them — raw text came back wearing a fabricated
    `01 01 01:01:01 # #` envelope it never had. A sample exists to show
    what was really in the log, so it is now the original line.
    """

    pattern: str
    count: int
    samples: list[str] = field(default_factory=list)
    # Where each sample sat in the input, 0-based and parallel to `samples`.
    # Grouping throws the original order away, so a caller that wants to
    # show samples in the order they were written — rather than in the
    # order their groups happened to sort — needs these to put them back.
    sample_lines: list[int] = field(default_factory=list)


@dataclass(frozen=True)
class Analysis:
    """Groups plus what petit had to do to produce them.

    `driver` names the entry class that parsed the text. `degraded` is True
    when detection picked a driver that then met a line it could not parse
    and RawEntry was used for the whole buffer instead — the grouping is
    still valid, but it is structural rather than format-aware.

    `lines_in` counts input lines; `lines_grouped` counts those that ended
    up in a group. They differ when entries scrub away to nothing (blank
    lines, `-- MARK --`), which petit drops. The two numbers are here so a
    caller can account for every line rather than wonder where they went.
    """

    groups: list[Group]
    driver: str
    degraded: bool
    lines_in: int
    lines_grouped: int


def _render(entry) -> str:
    """The entry's original line.

    Falls back to the parsed payload only for entries built by something
    other than CrunchLog._parse, which is the one place `raw` is set.
    """
    raw = getattr(entry, "raw", "")
    if raw:
        return raw
    payload = getattr(entry, "log_entry", None)
    return str(payload) if payload else repr(entry)


def _resolve_driver(name):
    """Map a driver name to its entry class, for callers that pin one."""
    if name is None:
        return None
    driver = getattr(_drivers, name, None)
    if driver is None or not isinstance(driver, type) \
            or not issubclass(driver, _drivers.LogEntry):
        raise PetitError("unknown driver: " + str(name))
    return driver


def analyze_text(
    text: str,
    *,
    filter_name: str = "hash.stopwords",
    max_samples: int = 3,
    source_name: str = "<text>",
    driver: str | None = None,
    strict: bool = False,
    stopwords: list[str] | None = None,
) -> Analysis:
    """Group `text` by line fingerprint and report how it was done.

    Deterministic: the same text yields the same analysis every time.

    Args:
        text: The log or payload to analyse.
        filter_name: Stopword file to apply, resolved from packaged data.
            Pass "__none__" for no filtering at all. Ignored when
            `stopwords` is given.
        stopwords: Regexes to normalise with, supplied by the caller and
            used instead of any packaged file. The packaged hash.stopwords
            is tuned for system logs and is deliberately aggressive —
            `[a-f]+#` collapses letters adjacent to a scrubbed number, so
            "bob0" and "boa0" group together. A caller that needs two
            distinct values to stay distinct supplies its own list.
        max_samples: Real lines to retain per group.
        source_name: Label used in errors and logging.
        driver: Pin an entry class by name (e.g. "RawEntry") instead of
            detecting one. A caller that needs grouping to be purely
            structural — no per-format vocabulary applied to its payloads —
            pins RawEntry and gets exactly that.
        strict: Raise ParseError when the driver meets a line it cannot
            parse, instead of falling back to RawEntry.

    Raises:
        EmptyLogError: `text` contained no data.
        ParseError: only when `strict`, or when `driver` was pinned and
            could not parse the text.
        DataFileError: `filter_name` was given but could not be read.
        PetitError: `driver` is not a known entry class.
    """
    log = CrunchLog.from_text(
        text,
        source_name=source_name,
        driver=_resolve_driver(driver),
        strict=strict,
    )
    hashed = SuperHash.manufacture(
        log,
        Filter.from_patterns(stopwords) if stopwords is not None else filter_name,
    )

    groups = [
        Group(
            pattern=str(key),
            count=value[0],
            samples=[_render(entry) for entry in value[1][:max_samples]],
            sample_lines=[
                getattr(entry, "line_number", -1) for entry in value[1][:max_samples]
            ],
        )
        for key, value in hashed.items()
    ]
    groups.sort(key=lambda g: (-g.count, g.pattern))

    return Analysis(
        groups=groups,
        driver=log.payload_type,
        degraded=log.degraded,
        lines_in=len(log),
        lines_grouped=sum(g.count for g in groups),
    )


def hash_text(
    text: str,
    *,
    filter_name: str = "hash.stopwords",
    max_samples: int = 3,
    source_name: str = "<text>",
    driver: str | None = None,
    strict: bool = False,
    stopwords: list[str] | None = None,
) -> list[Group]:
    """Group `text` by line fingerprint, most frequent first.

    The groups half of `analyze_text`, for callers that do not need to know
    which driver was used or whether it degraded. Arguments are identical.

    Returns:
        Groups sorted by descending count. An empty list only when `text`
        held nothing that survived scrubbing.
    """
    return analyze_text(
        text,
        filter_name=filter_name,
        max_samples=max_samples,
        source_name=source_name,
        driver=driver,
        strict=strict,
        stopwords=stopwords,
    ).groups


def detect_format(text: str, source_name: str = "<text>") -> str:
    """Name of the driver that claims `text`, without parsing all of it.

    Useful to a caller deciding whether petit is the right tool at all: a
    "RawEntry" answer means no driver recognised the format, so grouping will
    be structural at best.
    """
    log = CrunchLog.from_text(text, source_name=source_name)
    return log.payload_type
