"""Library entry points — petit's analysis without petit's command line.

Everything here takes text already in memory, returns data, and raises on
failure. No file paths, no stdout, no sys.exit. The CLI is one caller of this
module; a service embedding petit is another, and neither should have to
route a payload through a temporary file or lose its process to a bad line.

    from petit.api import hash_text

    for group in hash_text(open("/var/log/messages").read()):
        print(group.count, group.pattern)

The text is first cut into records — lines, JSON objects, or email
messages — by the first framer in `petit.records` that claims it. For line
records `CrunchLog` samples the buffer, each registered driver votes, and
the winner parses every record. Adding a driver to `CrunchLog` makes it
available here automatically.
"""

from __future__ import annotations

from collections.abc import Iterable
from dataclasses import dataclass, field
from typing import Any, Literal

from . import CrunchLog as _drivers
from .CrunchLog import CrunchLog
from .errors import PetitError
from .Filter import Filter
from .LogHash import MAX_KEY_CHARS, DaemonHash, HostHash, SuperHash, WordHash

HashMode = Literal["auto", "daemon", "host", "wordcount"]

# What each non-default hash mode groups by. "auto" lets the format pick.
_HASH_MODES: dict[str, type[SuperHash]] = {
    "daemon": DaemonHash,
    "host": HostHash,
    "wordcount": WordHash,
}


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
    # The part of each sample the driver treats as the message — the line
    # without the envelope its format wraps around it (timestamp, host,
    # daemon). Parallel to `samples`. The CLI prints this.
    sample_payloads: list[str] = field(default_factory=list)
    # Source lines each sample's record covered, [start, end), parallel to
    # `samples`. A one-line record is (n, n + 1); a JSON object or an email
    # spans more. A group made up by fingerprint collapsing has (-1, -1).
    sample_spans: list[tuple[int, int]] = field(default_factory=list)


@dataclass(frozen=True)
class Analysis:
    """Groups plus what petit had to do to produce them.

    `driver` names the entry class that parsed the text. `degraded` is True
    when detection picked a driver that then met a line it could not parse
    and RawEntry was used for the whole buffer instead — the grouping is
    still valid, but it is structural rather than format-aware.

    `lines_in` counts source lines; `lines_grouped` counts the source lines
    covered by records that ended up in a group. They differ when records
    scrub away to nothing (blank lines, `-- MARK --`), which petit drops.
    `records_in` and `records_grouped` count the same for records: equal to
    the line counts when every line is its own record, fewer when a framer
    joined lines into JSON objects or messages. `framer` names the framer
    that cut the text into records. These numbers are here so a caller can
    account for every line rather than wonder where they went.

    `fingerprints_matched` names the event corpora collapsed into a single
    group each, empty when none matched or `collapse_fingerprints` was off.
    """

    groups: list[Group]
    driver: str
    degraded: bool
    lines_in: int
    lines_grouped: int
    fingerprints_matched: list[str] = field(default_factory=list)
    records_in: int = 0
    records_grouped: int = 0
    framer: str = "line"


def _render(entry: _drivers.LogEntry) -> str:
    """The entry's original line.

    Falls back to the parsed payload only for entries built by something
    other than CrunchLog._parse, which is the one place `raw` is set.
    """
    raw = getattr(entry, "raw", "")
    if raw:
        return str(raw)
    payload = getattr(entry, "log_entry", None)
    return str(payload) if payload else repr(entry)


def _payload(entry: _drivers.LogEntry) -> str:
    """The message part of an entry: its parsed payload, which may be empty."""
    return str(entry.log_entry)


def _resolve_driver(name: str | None) -> type[_drivers.LogEntry] | None:
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
    filter_name: str | None = None,
    max_samples: int = 3,
    source_name: str = "<text>",
    driver: str | None = None,
    strict: bool = False,
    stopwords: list[str | tuple[str, str]] | None = None,
    hash_mode: HashMode = "auto",
    collapse_fingerprints: bool = False,
    framer: str = "auto",
    max_record_chars: int = MAX_KEY_CHARS,
) -> Analysis:
    """Group `text` by line fingerprint and report how it was done.

    Deterministic: the same text yields the same analysis every time.

    Args:
        text: The log or payload to analyse.
        filter_name: Stopword file to apply, resolved from packaged data.
            None, the default, asks the hash driver: each one declares the
            normalisation that suits its format (`DEFAULT_FILTER`). Pass
            "__none__" for no filtering at all. Ignored when `stopwords` is
            given.
        stopwords: Regexes to normalise with, supplied by the caller and
            used instead of any packaged file. The packaged hash.stopwords
            is tuned for system logs and is deliberately aggressive —
            `[a-f]+#` collapses letters adjacent to a scrubbed number, so
            "bob0" and "boa0" group together. A caller that needs two
            distinct values to stay distinct supplies its own list.
            Each entry is a regex, replaced with "#", or a
            (regex, replacement) pair when the fingerprint should say what
            was normalised away — "<TS>" and "<IP>" rather than "#".
        max_samples: Real lines to retain per group.
        source_name: Label used in errors and logging.
        driver: Pin an entry class by name (e.g. "RawEntry") instead of
            detecting one. A caller that needs grouping to be purely
            structural — no per-format vocabulary applied to its payloads —
            pins RawEntry and gets exactly that.
        strict: Raise ParseError when the driver meets a line it cannot
            parse, instead of falling back to RawEntry.
        hash_mode: What to group by. "auto" fingerprints each line with the
            hash driver for its format; "daemon" and "host" group by those
            fields; "wordcount" counts words.
        collapse_fingerprints: Replace every known routine event sequence
            (a reboot) found in the text with one group named after it.
            Off by default because it deletes lines. What matched is
            reported in `Analysis.fingerprints_matched`.
        framer: How to cut the text into records: "json" (a JSON array of
            objects or JSON Lines), "message" (RFC 822 mail), "multiline"
            (log messages whose continuation lines, such as a stack trace,
            join the timestamped line above them) or "line". "auto", the
            default, lets each claim the text in that order.
        max_record_chars: Longest text a record's fingerprint key is built
            from. Bounds the work stopword rules do on hostile input.
            Samples and raw text are never truncated.

    Raises:
        EmptyLogError: `text` contained no data.
        ParseError: only when `strict`, or when `driver` was pinned and
            could not parse the text.
        DataFileError: `filter_name` was given but could not be read.
        PetitError: `driver`, `hash_mode` or `framer` is not a known name,
            or a named framer does not recognise the text.
    """
    if hash_mode != "auto" and hash_mode not in _HASH_MODES:
        raise PetitError("unknown hash mode: " + str(hash_mode))

    log = CrunchLog.from_text(
        text,
        source_name=source_name,
        driver=_resolve_driver(driver),
        strict=strict,
        framer=framer,
    )
    policy = Filter.from_patterns(stopwords) if stopwords is not None else filter_name
    hashed = (
        SuperHash.manufacture(log, policy, max_record_chars) if hash_mode == "auto"
        else _HASH_MODES[hash_mode](log, policy, max_record_chars)
    )
    matched = hashed.fingerprint() if collapse_fingerprints else []

    groups = []
    for key, value in hashed.items():
        members = value[1][:max_samples]
        groups.append(Group(
            pattern=str(key),
            count=value[0],
            samples=[_render(entry) for entry in members],
            sample_lines=[getattr(entry, "line_number", -1) for entry in members],
            sample_payloads=[_payload(entry) for entry in members],
            sample_spans=[entry.span for entry in members],
        ))
    groups.sort(key=lambda g: (-g.count, g.pattern))

    grouped = _grouped_records(hashed.values())
    return Analysis(
        groups=groups,
        driver=log.payload_type,
        degraded=log.degraded,
        lines_in=log.lines_in,
        lines_grouped=_covered_lines(entry.span for entry in grouped),
        fingerprints_matched=matched,
        records_in=len(log),
        records_grouped=len(grouped),
        framer=log.framer,
    )


def _grouped_records(values: Iterable[list[Any]]) -> list[_drivers.LogEntry]:
    """Every distinct input record in a group, in no particular order.

    Distinct by identity: a --wordcount group lists a record once per word.
    Stand-ins for collapsed fingerprints came from no input and don't count.
    """
    seen: dict[int, _drivers.LogEntry] = {}
    for value in values:
        for entry in value[1]:
            if entry.span[0] >= 0:
                seen.setdefault(id(entry), entry)
    return list(seen.values())


def _covered_lines(spans: Iterable[tuple[int, int]]) -> int:
    """Source lines covered by `spans`, each counted once.

    JSON elements written on one line share it; summing their spans would
    count that line once per element.
    """
    covered = 0
    reach = -1
    for start, end in sorted(spans):
        begin = max(start, reach)
        if end > begin:
            covered += end - begin
        reach = max(reach, end)
    return covered


def hash_text(
    text: str,
    *,
    filter_name: str | None = None,
    max_samples: int = 3,
    source_name: str = "<text>",
    driver: str | None = None,
    strict: bool = False,
    stopwords: list[str | tuple[str, str]] | None = None,
    hash_mode: HashMode = "auto",
    collapse_fingerprints: bool = False,
    framer: str = "auto",
    max_record_chars: int = MAX_KEY_CHARS,
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
        hash_mode=hash_mode,
        collapse_fingerprints=collapse_fingerprints,
        framer=framer,
        max_record_chars=max_record_chars,
    ).groups


def detect_format(text: str, source_name: str = "<text>", framer: str = "auto") -> str:
    """Name of the driver that claims `text`, without parsing all of it.

    Useful to a caller deciding whether petit is the right tool at all: a
    "RawEntry" answer means no driver recognised the format, so grouping will
    be structural at best.
    """
    log = CrunchLog.from_text(text, source_name=source_name, framer=framer)
    return log.payload_type
