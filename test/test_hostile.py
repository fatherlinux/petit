"""Hostile input: petit parses bytes an attacker chose.

Every test here makes the same two claims about some input shaped to hurt:
the library returns an ordinary result or raises a PetitError — never
RecursionError, never SystemExit — and it does so in bounded time. Time
bounds are generous so a slow CI runner does not flake; what they catch is
quadratic or exponential behaviour, which misses them by orders of magnitude.
"""

from __future__ import annotations

import json
import time

import pytest

from petit import PetitError, analyze_text
from petit import records as framing
from petit.CrunchLog import CrunchLog, StructuredEntry

BUDGET_SECONDS = 5.0


def bounded(text: str, **kwargs):
    start = time.perf_counter()
    try:
        result = analyze_text(text, **kwargs)
    except PetitError:
        result = None
    elapsed = time.perf_counter() - start
    assert elapsed < BUDGET_SECONDS, f"took {elapsed:.1f}s"
    return result


class TestJsonBombs:
    def test_deep_array_nesting_is_declined(self):
        result = bounded("[" * 200_000 + "]" * 200_000)
        assert result is not None
        assert result.framer == "line"

    def test_deep_object_nesting_in_json_lines_is_declined(self):
        line = '{"a":' * 5_000 + "1" + "}" * 5_000
        result = bounded(line + "\n" + line + "\n")
        assert result is not None
        assert result.framer == "line"

    def test_nesting_within_the_limit_is_accepted(self):
        depth = framing.MAX_JSON_DEPTH - 1
        line = '{"a":' * depth + "1" + "}" * depth
        assert bounded(line + "\n" + line + "\n").framer == "json"

    def test_brackets_inside_strings_do_not_count_as_nesting(self):
        line = json.dumps({"text": "[" * 10_000})
        assert bounded(line + "\n" + line + "\n").framer == "json"

    def test_oversized_json_is_declined_not_parsed(self, monkeypatch):
        monkeypatch.setattr(framing, "MAX_JSON_CHARS", 1_000)
        text = json.dumps([{"k": "v" * 50} for _ in range(100)])
        assert bounded(text).framer == "line"

    def test_pinned_structured_driver_survives_a_deep_line(self):
        """Pinning StructuredEntry bypasses the framer's checks; the entry
        has to refuse with ValueError itself, so the run degrades instead
        of dying on RecursionError."""
        deep = '{"a":' * 50_000 + "1" + "}" * 50_000
        log = CrunchLog.from_text(deep + "\n", driver=StructuredEntry, framer="line")
        assert log.degraded

    def test_unterminated_string_is_declined(self):
        assert bounded('["' + "x" * 100_000 + "\n").framer == "line"


class TestLongRecords:
    def test_key_is_capped_but_samples_are_not(self):
        line = "a" * 1_000_000
        result = bounded(line + "\n", driver="RawEntry")
        group = result.groups[0]
        assert len(group.pattern) <= 4096
        assert group.samples[0] == line

    def test_key_cap_is_adjustable(self):
        result = bounded("x" * 10_000 + "\n", driver="RawEntry", max_record_chars=100)
        assert len(result.groups[0].pattern) == 100

    def test_huge_email_body_is_detected_quickly(self):
        body = ("word " * 20 + "\n") * 3_000
        thread = "".join(
            f"From: a{i}@example.com\nSubject: s\n\n{body}\n" for i in range(3)
        )
        assert bounded(thread).framer == "message"

    def test_email_quote_and_signature_probes(self):
        body = "> " * 100_000 + "\n" + "--" + " " * 100_000 + "\n"
        thread = "".join(f"From: a{i}@x\nSubject: s\n\n{body}\n" for i in range(2))
        assert bounded(thread).driver == "EmailEntry"

    def test_email_header_flood(self):
        headers = "".join(f"X-H{i}: v\n" for i in range(50_000))
        thread = "".join(f"From: a{i}@x\n{headers}\nbody\n\n" for i in range(2))
        assert bounded(thread).records_in == 2

    def test_one_enormous_line_of_digits(self):
        assert bounded("1" * 2_000_000 + "\n", driver="RawEntry") is not None


@pytest.mark.parametrize("filter_name", ["hash.stopwords", "strict.stopwords"])
@pytest.mark.parametrize("probe", [
    "0" * 200_000,
    "a-" * 100_000,
    "1." * 100_000,
    "0x" * 100_000,
    "Sep 22 " * 50_000,
    "2026-09-22T" * 30_000,
    "deadbeef" * 50_000,
    "::ffff:" * 50_000,
], ids=lambda probe: repr(probe[:12]))
def test_stopword_rules_are_linear(filter_name, probe):
    result = bounded(probe + "\n", driver="RawEntry", filter_name=filter_name,
                     max_record_chars=10**7)
    assert result is not None


@pytest.mark.parametrize("probe", [
    "Invalid user " + "a" * 200_000,
    "Failed password for " + "x " * 100_000,
    "Failed password for invalid user " + "b" * 200_000 + " from",
], ids=lambda probe: repr(probe[:24]))
def test_secure_generalizations_are_linear(probe):
    line = f"Sep 22 10:00:00 lotor sshd[1]: {probe}\n"
    result = bounded(line * 3, driver="SecureLogEntry", max_record_chars=10**7)
    assert result is not None
    assert result.lines_in == 3


@pytest.mark.parametrize("payload", [
    "\x00" * 10_000,
    "\ud800\udfff\n" * 10,
    '["\\ud800"]\n',
    "From: a\nTo: b\n\n" * 5_000,
    "\n" * 100_000,
    "{" * 100_000,
], ids=["nul", "surrogates", "json-surrogate", "header-flood", "blank-lines", "open-braces"])
def test_odd_bytes_never_escape_as_anything_but_petit_errors(payload):
    result = bounded(payload)
    assert result is not None
    assert result.lines_grouped <= result.lines_in
