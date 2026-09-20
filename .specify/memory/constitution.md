# petit Constitution

> **Version:** 1.0.0
> **Ratified:** 2026-09-20
> **Status:** Active
> **Inherits:** [crunchtools/constitution](https://github.com/crunchtools/constitution) v1.15.0
> **Profile:** CLI Tool

## Purpose

Log analysis for systems administrators: detects the log format, then
collapses the repetitive into counts so the unusual is what you read.

## License

AGPL-3.0-or-later.

## Versioning

Semantic Versioning 2.0.0. MAJOR for changes to the CLI flag set, exit code
contract, or library API (`petit.api`); MINOR for new flags, new library
functions, or new supported log formats; PATCH for bug fixes and internal
refactors with no observable behavior change.

## PyPI Naming Exception

The tool and command are `petit`; the PyPI distribution is `petit-log`, not
`petit`, because `petit` was already taken on PyPI by an unrelated protein
engineering toolkit at the time petit was first packaged for PyPI (see
`CHANGELOG.md` 3.0.0 and 2.0.0 entries — `petitlog` was also taken by a fork
of this same project). This is a documented exception to profile Section
VIII's PyPI-name-matches-tool-name convention, not an oversight.

## CLI Interface

Built with `argparse`. Flags: `-v/--verbose`, `--sample`/`--nosample`/
`--allsample`, `--filter`/`--nofilter`, `--wide`, `--tick`, `--fingerprint`,
`-V/--version`, and one mode flag per report: `--hash`, `--wordcount`,
`--daemon`, `--host`, `--sgraph`, `--mgraph`, `--hgraph`, `--dgraph`,
`--mograph`, `--ygraph`. One optional positional `file`; reads stdin when
omitted. Running `petit` with no flags at all prints the version.

Exit codes: `0` on success, `1` on a `PetitError` (bad input — unreadable
file, unparseable log, unknown driver name), `2` on a usage error (argparse
itself: unknown flag, more than one positional file).

## External APIs / Credentials

None. petit reads a local file or stdin and writes to stdout/stderr; it
makes no network calls and needs no credentials, so the
`~/.config/mcp-env/petit.env` convention does not apply.

## Library API

`petit.api` (`hash_text`, `analyze_text`, `detect_format`, `Group`,
`Analysis`, and the `PetitError` hierarchy) is a supported embedding surface
independent of the CLI — see `petit/api.py`'s module docstring.

## Container

Built on `quay.io/hummingbird/python:latest-fips`/`-fips-builder`,
multi-stage venv pattern. No extra system packages — pure stdlib. Published
to `quay.io/crunchtools/petit` and `ghcr.io/crunchtools/petit`.

## Testing

`test/test_api.py` covers the library surface with mocked-nothing-needed
unit tests (no external API, nothing to mock). `test/test_cli.py` covers the
CLI: the exit code contract, `--help`, and a byte-for-byte regression suite
against `test/data/` + `test/output/` fixtures that have been part of this
repo since 2009. Run via `uv run pytest -v`.

## Gourmand

Zero violations required. Config in `gourmand.toml`, exceptions in
`gourmand-exceptions.toml`.

## Quality Gates

1. Lint — `uv run ruff check src test`
2. Type Check — `uv run mypy src`
3. Tests — `uv run pytest -v`
4. Gourmand — `gourmand --full .`
5. Container Build — `podman build -f Containerfile .`
