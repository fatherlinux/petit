# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [4.0.0] - 2026-09-22

### Changed
- **Breaking: input is framed into records before driver selection.**
  `--framer {auto,line,json,message}` and `analyze_text(framer=...)` default
  to `auto` for both the CLI and the library, so `petit --hash big.json` and
  `petit --hash thread.eml` now group per JSON object and per message rather
  than per line. `--framer line` restores the old behaviour. test01–test13
  are byte-identical: no framer but the line framer claims them.
- **Breaking: `Analysis.lines_in` and `lines_grouped` count source lines.**
  `lines_in` is the number of lines in the input, and `lines_grouped` is the
  number of source lines covered by grouped records, each line counted once.
  With one record per line both are unchanged. `records_in`,
  `records_grouped` and `framer` are new.
- `SuperHash.manufacture()` looks the hash driver up in a `HASH_FOR` table
  along the entry class's MRO, replacing an if/elif over the class of the
  last entry. A subclass of an entry driver now gets its parent's hash
  driver instead of whichever branch matched first. A characterization test
  pins every existing entry driver to the hash driver the old chain chose.
- Driver detection looks at the first 2000 characters of a record
  (`DETECT_MAX_CHARS`).

### Added
- `petit.records`: `Record`, `JsonFramer` (JSON arrays of objects and JSON
  Lines), `MessageFramer` (mail threads and mbox), `LineFramer`.
- `StructuredEntry` and `StructuredHash`: JSON records are fingerprinted by
  shape, with keys verbatim, values normalized by type, and strings of 200
  characters or fewer kept verbatim so that prose can't merge away.
- `analyze_text(max_record_chars=4096)`: bounds the text a fingerprint key is
  built from. Samples and raw text are never truncated.
- `Group.sample_spans`: the source lines each sample's record covered.
- `test/data/test14.log` (JSON array) and `test15.log` (mail thread) with
  fixtures, `test/test_records.py`, and `test/test_hostile.py`: deep nesting,
  oversized records, pathological regex probes, and odd bytes, each with a
  time budget.
- Constitution 1.1.0: a hostile-input clause in Testing, and the rule that the
  CLI is a shell over the library.

### Fixed
- The man page documented `--fingerprint` as `--finterprint`.

## [3.2.0] - 2026-09-22

### Changed
- The CLI is now a thin shell over `petit.api`: every `--hash`, `--daemon`,
  `--host` and `--wordcount` run is `analyze_text()` on the file's text.
  `test/output/*` is byte-identical across this refactor.
- Hash drivers own their normalization. Each declares `KEY_FIELDS`,
  `GENERALIZATIONS` and `DEFAULT_FILTER`, and `analyze_text`/`hash_text`'s
  `filter_name` now defaults to `None`, meaning "ask the driver". Explicit
  `filter_name=` or `stopwords=` still win. The rule for what a
  generalization may swallow is in `LogHash.py`'s docstring and the new
  `docs/drivers.md`.
- Raw text (`RawLogHash`) now normalizes with the new `strict.stopwords`
  instead of `hash.stopwords`, so identifiers like `web01`/`web02` and
  `PROJ-1234`/`PROJ-1235` stay distinct. Reviewed fixture diff:
  `test04-hash-nosample.output` (`#` → `<N>`).
- `SecureLogHash` keeps the user name the client supplied. `Invalid user.*`
  and `Failed password for.*from.*` (and `Failed password for invalid
  user.*`) swallowed the name and everything after it; they now collapse only
  the source address, and a name containing a space doesn't match at all.
  The `input_userauth_request: invalid user` and `error retrieving
  information about user` rules were removed for the same reason. No
  fixture moves: test08 contains none of these lines.
- `--allsample` shows each group's first member instead of a random one.

### Added
- `analyze_text(hash_mode="auto"|"daemon"|"host"|"wordcount")`: every
  grouping the CLI offers is reachable from the library.
- `analyze_text(collapse_fingerprints=True)` and
  `Analysis.fingerprints_matched`: reboot-sequence collapsing, previously
  CLI-only (`--fingerprint`).
- `Group.sample_payloads`: each sample's message without its envelope.
- `strict.stopwords`, and filter files may give a replacement per rule as
  `regex<TAB>replacement` (a bare regex still means `#`).
- `test/test_drivers.py`: MERGE/NO_MERGE example pairs for every hash driver.

### Fixed
- Fingerprint corpora were re-read and re-parsed from disk on every call;
  they are now cached by path and modification time. Matching no longer
  overwrites the corpus's own entry in place.
- Site-local fingerprint corpora (`/var/lib/petit/fingerprints/` etc.) were
  never read, because only the first directory with files was searched and
  the packaged one always has files. All directories are now read.
- A misspelt or missing filter name silently filtered nothing; it now raises
  `DataFileError`.
- Files and strings split into lines the same way. `from_text` used
  `str.splitlines()`, which also breaks on form feeds and U+2028, and
  `\r\n` input kept a trailing `\r` in its samples.
- A file that isn't valid UTF-8 exits 1 with a message instead of a
  traceback.
- `--wordcount` groups now hold the lines each word came from, so library
  samples are real lines rather than the word repeated.

## [3.1.1] - 2026-09-20

### Fixed
- The 3.1.0 PyPI upload was rejected (trusted publisher was registered as a
  new-project pending publisher instead of on the existing project's
  Publishing settings). While fixing this on PyPI, the distribution name
  changed to `petit-log-crunchtools`, matching the naming convention
  already used elsewhere in the crunchtools fleet (`gatehouse-crunchtools`,
  `mcp-gemini-crunchtools`). `petit --version` now looks up the installed
  package under the new name; it would otherwise report "unknown" once
  installed from PyPI.

## [3.1.0] - 2026-09-20

### Changed
- Relicensed from GPL-3.0-or-later to AGPL-3.0-or-later, per the
  [crunchtools constitution](https://github.com/crunchtools/constitution).
  Scott McCarty is the sole copyright holder.
- Raised the minimum supported Python from 3.9 to 3.11, matching the
  constitution's CLI Tool profile.
- Rewrote the CLI argument parser from `optparse` to `argparse` (profile
  mandates argparse; `optparse` is legacy stdlib). Every flag, default, and
  the `--help` text are unchanged; the mode dispatch no longer uses `eval()`.
- Added type annotations across the library so `mypy --strict` passes with
  zero errors.
- Converted `CHANGELOG` (RPM-style) to `CHANGELOG.md` (Keep a Changelog).

### Added
- `.github/workflows/`: CI (lint, mypy, pytest on 3.11/3.12, Gourmand,
  container build, constitution validation), a weekly security scan (CVE
  audit + CodeQL), dual-registry container publishing (Quay.io + GHCR), and
  PyPI trusted publishing on release tags.
- `Containerfile` on the Hummingbird multi-stage build pattern.
- `.specify/memory/constitution.md` declaring the CLI Tool profile.
- `gourmand.toml` / `gourmand-exceptions.toml`.
- `.github/dependabot.yml` for the `uv` and `github-actions` ecosystems.
- `uv.lock`, committed per constitution XV.
- `test/test_cli.py`: CLI integration tests covering the exit code contract
  (0/1/2) and byte-for-byte output regression against the existing
  `test/data`/`test/output` fixtures.

### Fixed
- `petit --version` printed a hardcoded `2.0.0` since the 2.0.0 release; it
  now reports the installed package version.

### Removed
- The legacy `Makefile`, `build/` (rpm/deb/tar/distutils scripts), and
  `distribute/` directories — superseded by `uv build` + CI.
- `src/petit/ScriptLog.py`: dead code, unreferenced by the package and
  unimportable under Python 3 (`import sha`, a Python 2-only module) since
  the 2.0.0 port.
- `test/test.sh`: superseded by `test/test_cli.py`.

## [3.0.0] - 2026-09-19

### Changed
- **BREAKING**: the import package is now `petit`, not `crunchtools`. Update
  `from crunchtools import hash_text` to `from petit import hash_text`.
- **BREAKING**: the PyPI distribution is now `petit-log`, not `crunchtools`.
  `crunchtools` was this project's brand, not this tool's name — spending it
  on one log analyser left nothing for anything else that ships under it,
  and meant the repo, the distribution, the import and the command were
  four different words for one program. `petit` alone was unavailable on
  PyPI (a protein engineering toolkit holds it), hence `petit-log`.
- The repository moved to `github.com/crunchtools/petit`.
- The `petit` command and every flag are unchanged, as is the library API
  beyond the import path: `hash_text`, `analyze_text`, `detect_format`,
  `Group`, `Analysis`, and the `PetitError` hierarchy all behave exactly as
  in 2.2.0.
- `crunchtools` 2.1.0 remains on PyPI and is not superseded by an upload;
  the name is being kept for a future package under that brand.

## [2.2.0] - 2026-09-19

### Changed
- Made driver selection deterministic. `select()` drew its sample lines
  with `random.choice()`, so the driver — and therefore the entire result —
  was a function of the RNG as well as the input. The same bytes could
  parse two different ways, or succeed on one call and raise on the next.
  It now samples evenly spaced lines, which is reproducible and, because it
  always looks at the head and the tail, better evidence than a random
  draw.
- A line the selected driver cannot parse no longer aborts the run. The
  driver is chosen from a sample and then applied to every line, so one
  stack trace in an application log, or one prose line in mixed tool
  output, used to raise `ParseError` and lose the other four hundred
  lines. It now falls back to `RawEntry` and reports `Analysis.degraded`.
  Pass `strict=True` for the old behaviour.
- Samples are now the original lines, byte for byte. They were rebuilt
  from parsed fields, which invented data: formats carrying no timestamp
  were rendered with a placeholder `01 01 01:01:01 # #` envelope they
  never had.
- `SecureLogHash` no longer mutates the log it is fingerprinting. `fill()`
  assigned its generalised form back onto each entry, so hashing a secure
  log destroyed it for every later reader — the user name and source
  address, the only reason to read a sample, were gone. The rules now
  build the key from a local copy.

### Fixed
- Fixed `select()` re-counting votes across rounds. One `Tally` was reused
  while the sample list grew, so round three weighed the first ten lines
  three times.

### Added
- Added `analyze_text()`, which returns the groups plus the driver used,
  whether it degraded, and lines in versus lines grouped, so a caller can
  account for every line rather than wonder where they went.
- Added a `driver=` argument to pin an entry class instead of detecting
  one. A caller that must not have per-format vocabulary applied to its
  payloads pins `RawEntry` and gets purely structural grouping. Unknown
  names raise `PetitError`.
- Added a `stopwords=` argument taking regexes from the caller, used
  instead of any packaged filter file. Normalisation policy belongs to
  whoever reads the output: `hash.stopwords` is tuned for system logs and
  deliberately aggressive, and its `[a-f]+#` rule collapses letters next
  to a scrubbed number, so "bob0" and "boa0" group together. Right for
  spotting a flapping daemon, wrong for a caller that needs two distinct
  values to stay distinct.
- `stopwords=` entries may be `(regex, replacement)` pairs as well as bare
  regexes, so a fingerprint can say what it normalised away: `<TS> host
  sshd[<N>]: login from <IP>` rather than `# host sshd[#]: login from #`.
  Patterns loaded from a file keep the `#` scrub character petit has
  always used.
- Added `Group.sample_lines`, the 0-based position of each sample in the
  input. Grouping throws the original order away, so a caller that wants
  to show samples in written order rather than in group order had no way
  back.
- `hash_text()` and `detect_format()` are unchanged for existing callers,
  and the petit command line produces byte-identical output on the full
  test corpus.

## [2.1.0] - 2026-09-18

### Added
- Added a library API: `crunchtools.hash_text()` and
  `crunchtools.detect_format()`.
- Added `CrunchLog.from_text()` so callers can analyse a string without a
  file.
- Packaged with `pyproject.toml` as the `crunchtools` distribution on
  PyPI, with `petit` as a console script. The name "petit" on PyPI belongs
  to an unrelated project.

### Fixed
- Fixed an infinite loop in `select()`: a buffer no driver claimed (blank
  lines, for instance) spun forever and grew its sample list on every
  pass. Bounded to `MAX_SELECT_ROUNDS` with a fall back to `RawEntry`.
- Fixed a missing comma in the fingerprint prefix list that joined two
  paths into one, so `/opt` was never actually searched.
- Made 7 regex literals raw (`SyntaxWarning` today, `SyntaxError` on a
  future Python) and escaped a literal `[` in a character class.
- Fixed #16: an unreadable or missing file escaped as a `PermissionError`
  traceback. It now raises `DataFileError`, which the CLI reports as
  `petit: cannot read <path>: Permission denied` and exits 1. Reported by
  Pablo Iranzo Gomez in 2022.
- The petit command line is unchanged: `--hash`, `--daemon`, `--host` and
  `--wordcount` all behave exactly as before.

### Removed
- Removed all 13 `sys.exit()` calls from library code; they raise
  `PetitError` subclasses now, and only the CLI turns those into an exit
  status.
- Removed `eval()` from the driver-detection path; `entry_types` holds the
  classes rather than their names. Auto-registration of new drivers is
  unchanged.
- Dropped the `sys.path` and `warnings.simplefilter` side effects from
  package import; a library should not mutate global state when it is
  imported.

### Changed
- Fingerprints and stopwords now ship inside the package and resolve
  through `importlib.resources`, so a pip install has its data. They were
  only ever installed to `/var/lib/petit` by the distro packaging, which
  meant filtering silently did nothing anywhere else.

## [2.0.0] - 2022-10-13

### Changed
- Ported to Python 3.
- Cleaned up to PEP 8 and added the `Tally` class to simplify
  driver-selection logic (committed 2011-04-16, the day after the 1.1.1
  tag, so it waited here).
- Reorganised the directory structure.
- (Recorded retroactively in 2026 — this release shipped without a
  changelog entry at the time.)

### Fixed
- Fixed Test 12; the suite passes again.

### Not merged during this period
Proposed but not merged, so none of it is in the code. Recorded because
the history is otherwise invisible; all four were opened by Pablo Iranzo
Gomez (iranzo) in Oct 2022 and closed unmerged in Nov 2024:
- #12 packaging for PyPI. Published independently as `petitlog` 2.0.0.post3
  on 2022-10-17 — https://pypi.org/project/petitlog/ — which is why that
  name is taken. It is this project, credited to Scott McCarty, and is
  unrelated to the `crunchtools` distribution published in 2026.
- #14 GitHub Actions to help with release tagging.
- #15 pre-commit configuration, applied across the code.
- #17 permission check in CrunchLog.py to avoid a traceback on unreadable
  files (closes #16).

## [1.1.1] - 2011-04-15

### Added
- Added `re.escape` to variable based regex.
- Added debugging output for graph.
- Added patch for bug with determining month.
- Added empty log data test, new test output for broken apache error log,
  and new test files.
- Added path for logs with no data.
- Added try/catch for interspersed wrong data problem.
- Added better documentation for rsyslog.

### Fixed
- Fixed index bug in syslog entry and rsyslog.

### Changed
- Updated outputs for new patch and year change.
- Updated description of tests.

## [1.1.0] - 2010-11-09

### Changed
- Finished conversion of crunchtools to a module.
- Passes all tests again.

## [1.0.4] - 2010-11-08

### Fixed
- Updated version because of a problem with rpdb2.

## [1.0.3] - 2010-06-25

### Fixed
- Patched to allow mixed precision when Ubuntu 8.04 logs to an Ubuntu
  10.04 server with high precision.

## Pre-1.0 history

These predate version numbering — the original changelog recorded them by
date only, with no corresponding git tag or release number. Dates are
preserved here rather than assigned invented version numbers.

### 2010-06-24
- Added support for rsyslogd precision time format.
- Added fingerprints for Ubuntu 10.04.
- Added NAME section to man page.

### 2010-02-27
- Added apache error log support and tests.
- Added man page.
- Added fingerprints for Ubuntu 9.04.

### 2010-02-12
- Moved a bunch of code into the `select` function of the Log object so
  that it can now randomly sample ten entries over and over until it
  determines what kind of file has been opened.
- Now passes all regression tests, all the time.

### 2010-01-18
- Changed defaults for entries to 1900 so that time delta calculations do
  not fail.
- Changed log determination logic to use multiple samples.
- Fixed bug in SecureLog processing where sample line was not being
  checked for long enough line.
- Added string conversion to all known log types to resolve type bugs
  casting strings and numbers.

### 2010-01-15
- Added Linux secure log processing capabilities.
- Added month graph and year graph (syslog carries no year data, so
  don't draw wrong conclusions from either).
- Added year support in code.
- Added Days graph.
- Added normalization code for better differentiation of close values,
  handling most edge cases.
- Removed first sample, replaced by random sampling for log type
  determination (later made deterministic in 2.2.0).
- Completely revamped date delta code using `datetime` built-in
  functionality to calculate date/time ranges.
- Re-architected and redesigned graphing logic and output to better match
  cacti/RRD. Kept graphing as separate classes per graph type rather than
  a more "object-oriented" hierarchy — closer to report writing than
  inheritance.
- Fixed documentation/help menu text.
- Fixed bug in value calculations of each bar of graph; values were
  erroring low.

### 2009-07-31
- First working version.

[Unreleased]: https://github.com/crunchtools/petit/compare/v3.1.1...HEAD
[3.1.1]: https://github.com/crunchtools/petit/releases/tag/v3.1.1
[3.1.0]: https://github.com/crunchtools/petit/releases/tag/v3.1.0
[3.0.0]: https://github.com/crunchtools/petit/releases/tag/v3.0.0
