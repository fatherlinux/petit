"""Framing: records that are not lines, and what that does to the accounting."""

from __future__ import annotations

import json
import os

import pytest

from petit import PetitError, analyze_text, hash_text
from petit.CrunchLog import (
    ApacheAccessEntry,
    ApacheErrorEntry,
    CrunchLog,
    RawEntry,
    RSyslogEntry,
    SecureLogEntry,
    SnortEntry,
    SyslogEntry,
    entry_types,
)
from petit.LogHash import (
    ApacheLogHash,
    RawLogHash,
    SecureLogHash,
    SnortLogHash,
    SuperHash,
    SyslogHash,
    hash_for,
)
from petit.records import JsonFramer, LineFramer, MessageFramer, Record

DATA = os.path.join(os.path.dirname(__file__), "data")


def fixture_lines(name: str) -> list[str]:
    with open(os.path.join(DATA, name)) as handle:
        return handle.readlines()


class TestBackwardCompatibility:
    @pytest.mark.parametrize("number", range(1, 13))
    def test_only_the_line_framer_claims_the_2009_corpus(self, number):
        """The load-bearing fact: test01-test13 frame exactly as before."""
        buf = fixture_lines(f"test{number:02d}.log")
        assert not JsonFramer.claims(buf)
        assert not MessageFramer.claims(buf)

    def test_line_records_are_the_lines(self):
        buf = ["one\n", "two\n"]
        assert LineFramer.frame(buf) == [Record(["one\n"], 0, 1), Record(["two\n"], 1, 2)]


class TestJsonFramer:
    ARRAY = '[\n  {"a": 1},\n  {"a": 2,\n   "b": "x"}\n]\n'

    def test_array_elements_map_to_their_source_lines(self):
        records = JsonFramer.frame(self.ARRAY.splitlines(keepends=True))
        assert [(r.start, r.end) for r in records] == [(1, 2), (2, 4)]
        assert [json.loads(r.text) for r in records] == [{"a": 1}, {"a": 2, "b": "x"}]

    def test_compact_array_shares_one_line(self):
        records = JsonFramer.frame(['[{"a": 1}, {"a": 2}]\n'])
        assert [r.text for r in records] == ['{"a": 1}', '{"a": 2}']
        assert all((r.start, r.end) == (0, 1) for r in records)

    def test_json_lines_skip_blank_lines(self):
        buf = ['{"a": 1}\n', "\n", '{"a": 2}\n']
        assert JsonFramer.claims(buf)
        assert [(r.start, r.end) for r in JsonFramer.frame(buf)] == [(0, 1), (2, 3)]

    @pytest.mark.parametrize("text", [
        "[1, 2, 3]\n",
        "[]\n",
        '{"a": 1}\nnot json\n',
        '{"a": 1,\n "b": 2}\n',
        '"just a string"\n',
    ])
    def test_declines_what_is_not_objects(self, text):
        assert not JsonFramer.claims(text.splitlines(keepends=True))


class TestMessageFramer:
    def test_splits_a_thread_on_header_blocks(self):
        buf = fixture_lines("test15.log")
        assert MessageFramer.claims(buf)
        records = MessageFramer.frame(buf)
        assert len(records) == 4
        assert all(r.text.startswith("From: ") for r in records)
        assert records[-1].end == len(buf)

    def test_mbox_separators(self):
        buf = ["From a@x Mon Sep 22\n", "Subject: one\n", "\n", "body\n", "\n",
               "From b@x Mon Sep 22\n", "Subject: two\n", "\n", "body\n"]
        assert [(r.start, r.end) for r in MessageFramer.frame(buf)] == [(0, 5), (5, 9)]

    def test_a_single_message_is_not_a_thread(self):
        assert not MessageFramer.claims(["From: a@x\n", "Subject: s\n", "\n", "body\n"])

    def test_key_value_prose_is_not_mail(self):
        buf = ["Note: one\n", "Status: ok\n", "\n", "Note: two\n", "Status: ok\n"]
        assert not MessageFramer.claims(buf)


class TestAccounting:
    def test_line_framed_counts_are_unchanged(self):
        result = analyze_text("".join(fixture_lines("test08.log")))
        assert result.framer == "line"
        assert result.records_in == result.lines_in == 1500
        assert result.records_grouped == result.lines_grouped

    def test_json_counts_source_lines_not_records(self):
        result = analyze_text("".join(fixture_lines("test14.log")))
        assert result.framer == "json"
        assert result.driver == "StructuredEntry"
        assert result.records_in == 11
        assert result.lines_in == 168
        # Every line but the array's own brackets belongs to a record.
        assert result.lines_grouped == 166

    def test_compact_json_lines_are_not_double_counted(self):
        result = analyze_text('[{"a": 1}, {"a": 2}, {"a": 3}]\n')
        assert result.records_in == 3
        assert result.lines_grouped == 1

    def test_sample_spans_are_parallel_and_honest(self):
        lines = fixture_lines("test14.log")
        for group in analyze_text("".join(lines)).groups:
            assert len(group.sample_spans) == len(group.samples)
            for (start, end), sample in zip(group.sample_spans, group.samples, strict=True):
                assert sample.strip() in "".join(lines[start:end])
                assert group.sample_lines[0] >= 0

    def test_framer_can_be_forced(self):
        text = "".join(fixture_lines("test14.log"))
        assert analyze_text(text, framer="line").framer == "line"

    def test_forcing_a_framer_that_does_not_fit_is_an_error(self):
        with pytest.raises(PetitError):
            analyze_text("plain text\n", framer="json")

    def test_unknown_framer_is_rejected(self):
        with pytest.raises(PetitError):
            analyze_text("plain text\n", framer="xml")


class TestStructuredGrouping:
    def test_injected_instruction_stays_its_own_group(self):
        groups = hash_text("".join(fixture_lines("test14.log")))
        odd = [g for g in groups if "ignore previous instructions" in g.pattern]
        assert len(odd) == 1
        assert odd[0].count == 1


class TestHashDispatch:
    """manufacture() used to be an if/elif over the class of the last
    entry, with RawEntry tested before SecureLogEntry. A subclass of an
    entry driver fell to whichever branch came first."""

    @staticmethod
    def old_chain(entry_cls: type) -> type[SuperHash]:
        chain = [
            ((SyslogEntry, RSyslogEntry), SyslogHash),
            ((ApacheAccessEntry, ApacheErrorEntry), ApacheLogHash),
            ((SnortEntry,), SnortLogHash),
            ((RawEntry,), RawLogHash),
            ((SecureLogEntry,), SecureLogHash),
        ]
        for classes, hash_cls in chain:
            if issubclass(entry_cls, classes):
                return hash_cls
        raise AssertionError(f"old chain had no branch for {entry_cls.__name__}")

    @pytest.mark.parametrize(
        "entry_cls",
        [e for e in entry_types if e.__name__ != "StructuredEntry"],
        ids=lambda e: e.__name__,
    )
    def test_table_matches_the_old_chain(self, entry_cls):
        assert hash_for(entry_cls) is self.old_chain(entry_cls)

    def test_subclass_inherits_its_parents_hash_driver(self):
        class CustomSecure(SecureLogEntry):
            pass

        assert hash_for(CustomSecure) is SecureLogHash

    def test_manufacture_follows_the_parsed_driver(self):
        log = CrunchLog.from_text("".join(fixture_lines("test08.log")))
        assert type(SuperHash.manufacture(log)) is SecureLogHash
