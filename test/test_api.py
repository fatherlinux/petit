"""Library API: text in, data out, exceptions on failure."""

import pytest

from crunchtools import (
    EmptyLogError,
    ParseError,
    PetitError,
    analyze_text,
    detect_format,
    hash_text,
)
from crunchtools import resources


def secure_log(lines=200, pids=(1234, 5678)):
    """Realistic sshd output: a few PIDs across many lines.

    Deliberately not one PID per line — petit keys on the daemon field, which
    includes the PID, so a log with a unique PID per line cannot group and
    would make this suite pass for the wrong reason.
    """
    return "\n".join(
        "Aug 18 10:%02d:%02d lotor sshd[%d]: "
        "Accepted publickey for scott from 10.0.0.%d port %d"
        % (i % 60, i % 60, pids[i % len(pids)], i % 250, 3000 + i)
        for i in range(lines)
    )


class TestDetection:
    def test_picks_a_driver_for_secure_logs(self):
        assert detect_format(secure_log()) == "SecureLogEntry"

    def test_unrecognised_text_falls_back_to_raw(self):
        prose = "\n".join("the quick brown fox jumps over it" for _ in range(30))
        assert detect_format(prose) == "RawEntry"


class TestHashText:
    def test_collapses_repetitive_lines(self):
        groups = hash_text(secure_log())
        assert len(groups) < 10
        assert sum(g.count for g in groups) == 200

    def test_sorted_by_descending_count(self):
        counts = [g.count for g in hash_text(secure_log())]
        assert counts == sorted(counts, reverse=True)

    def test_samples_are_the_original_lines(self):
        """Samples must be exactly what was in the input.

        They used to be rebuilt from parsed fields, and SecureLogHash had
        already overwritten the payload in place, so the caller got
        "Accepted publickey for #" — the user and source address, the only
        reason to look at a sample, were gone.
        """
        text = secure_log()
        top = hash_text(text)[0]
        assert top.samples
        sample = top.samples[0]
        assert "object at 0x" not in sample
        assert sample in text.splitlines()
        assert "Accepted publickey for scott" in sample

    def test_max_samples_is_honoured(self):
        top = hash_text(secure_log(), max_samples=1)[0]
        assert len(top.samples) == 1


class TestFailureModes:
    def test_empty_input_raises_instead_of_exiting(self):
        """The whole point of the library API: a bad payload must not take
        the caller's process down with it."""
        with pytest.raises(EmptyLogError):
            hash_text("")

    def test_hostile_input_does_not_escape_as_systemexit(self):
        for payload in ("\x00\x00\x00", "[" * 5000, "\n" * 100):
            try:
                hash_text(payload)
            except SystemExit:  # pragma: no cover - the regression guard
                pytest.fail("library raised SystemExit on hostile input")
            except Exception:
                pass


class TestPackagedData:
    def test_stopword_files_ship_with_the_package(self):
        """These used to live only in /var/lib/petit, so a pip install had no
        data at all and filtering silently did nothing."""
        assert resources.find("filters", "hash.stopwords") is not None

    def test_legacy_system_paths_are_still_searched_last(self):
        prefixes = resources.search_prefixes("fingerprints")
        assert "/var/lib/petit/fingerprints/" in prefixes
        assert prefixes[0] != "/var/lib/petit/fingerprints/"

    def test_opt_prefix_is_a_separate_entry(self):
        """Regression: the old list was missing a comma, so two paths were
        concatenated into one and /opt was never actually searched."""
        prefixes = resources.search_prefixes("fingerprints")
        assert "/opt/petit/var/lib/fingerprints/" in prefixes


class TestFileErrors:
    """Issue #16: an unreadable or missing file used to escape as a raw
    traceback. Reported by Pablo Iranzo Gomez in 2022; PR #17 proposed an
    os.access() check and was closed unmerged, so it stayed broken."""

    def test_unreadable_file_raises_cleanly(self, tmp_path):
        import os

        from crunchtools.CrunchLog import CrunchLog
        from crunchtools import DataFileError

        target = tmp_path / "noperm.log"
        target.write_text("Aug 18 10:00:00 host sshd[1]: test\n")
        os.chmod(target, 0o000)
        try:
            if os.access(target, os.R_OK):  # running as root; nothing to test
                pytest.skip("cannot make a file unreadable as this user")
            with pytest.raises(DataFileError):
                CrunchLog(str(target))
        finally:
            os.chmod(target, 0o644)

    def test_missing_file_raises_cleanly(self, tmp_path):
        from crunchtools.CrunchLog import CrunchLog
        from crunchtools import DataFileError

        with pytest.raises(DataFileError):
            CrunchLog(str(tmp_path / "does-not-exist.log"))


def mixed_log(syslog_fraction=0.7, lines=40):
    """A buffer whose shape changes part way through — the ordinary case for
    application logs and for tool output that interleaves JSON with prose."""
    k = int(lines * syslog_fraction)
    return "\n".join(
        ["Sep 19 04:00:%02d lotor sshd[%d]: Accepted publickey for scott "
         "from 10.0.0.%d port 22" % (i, i, i) for i in range(k)]
        + ["an ordinary prose sentence slipped into the stream here"
           for _ in range(lines - k)]
    )


class TestDeterminism:
    """Selection used to draw sample lines with random.choice, so the driver
    — and therefore the whole result — depended on the RNG as well as the
    input. The same bytes could parse two different ways, or succeed on one
    call and raise on the next."""

    def test_detection_is_stable_across_calls(self):
        text = mixed_log()
        assert len({detect_format(text) for _ in range(50)}) == 1

    def test_grouping_is_stable_across_calls(self):
        text = mixed_log()
        shapes = {
            tuple((g.pattern, g.count) for g in hash_text(text))
            for _ in range(50)
        }
        assert len(shapes) == 1

    def test_stable_at_every_mixture(self):
        for fraction in (0.3, 0.5, 0.7, 0.9):
            text = mixed_log(fraction)
            assert len({detect_format(text) for _ in range(30)}) == 1


class TestMixedInput:
    """A driver is chosen from a sample and then applied to every line, so
    one line in another shape used to abort the entire run."""

    def test_unparseable_line_degrades_instead_of_raising(self):
        text = secure_log() + "\nan ordinary prose sentence in the stream"
        result = analyze_text(text)
        assert result.degraded is True
        assert result.driver == "RawEntry"

    def test_degraded_run_still_accounts_for_every_line(self):
        text = secure_log() + "\nan ordinary prose sentence in the stream"
        result = analyze_text(text)
        assert result.lines_in == 201
        assert result.lines_grouped == 201

    def test_the_odd_line_out_survives_into_a_sample(self):
        """The interloper is the interesting line. Losing it to a parse
        error, or silently dropping it, defeats the point of the tool."""
        text = secure_log() + "\nan ordinary prose sentence in the stream"
        groups = hash_text(text)
        assert any(
            "ordinary prose sentence" in sample
            for group in groups
            for sample in group.samples
        )

    def test_strict_restores_the_old_raising_behaviour(self):
        text = secure_log() + "\nan ordinary prose sentence in the stream"
        with pytest.raises(ParseError):
            analyze_text(text, strict=True)

    def test_a_clean_log_is_not_marked_degraded(self):
        assert analyze_text(secure_log()).degraded is False


class TestDriverOverride:
    """A caller that must not have per-format vocabulary applied to its
    payloads pins RawEntry and gets purely structural grouping."""

    def test_pinning_raw_skips_detection(self):
        assert analyze_text(secure_log(), driver="RawEntry").driver == "RawEntry"

    def test_pinned_raw_does_not_generalise_the_payload(self):
        """SecureLogHash collapses everything after "Invalid user", which is
        exactly the part a caller may need to keep distinct."""
        boilerplate = "\n".join(
            "Sep 19 04:00:%02d lotor sshd[%d]: Invalid user bob%d from 10.0.0.%d"
            % (i, i, i, i) for i in range(50)
        )
        text = boilerplate + (
            "\nSep 19 04:59:59 lotor sshd[99]: Invalid user DISTINCTIVE from 10.0.0.99"
        )
        detected = analyze_text(text)
        assert len(detected.groups) == 1

        pinned = analyze_text(text, driver="RawEntry", filter_name="__none__")
        assert any("DISTINCTIVE" in g.pattern for g in pinned.groups)

    def test_unknown_driver_is_rejected(self):
        with pytest.raises(PetitError):
            analyze_text(secure_log(), driver="NoSuchEntry")

    def test_driver_name_cannot_reach_arbitrary_attributes(self):
        for name in ("re", "sys", "CrunchLog", "__builtins__"):
            with pytest.raises(PetitError):
                analyze_text(secure_log(), driver=name)


class TestNoFabricatedFields:
    def test_raw_text_samples_do_not_invent_an_envelope(self):
        """Raw text has no timestamp, host or daemon. Rendering from parsed
        fields supplied placeholders for all three, so a JSON line came back
        as "01 01 01:01:01 # # ..." — data the input never contained."""
        text = "\n".join('  "key": "PROJ-%d",' % i for i in range(30))
        for group in hash_text(text):
            for sample in group.samples:
                assert "01 01 01:01:01" not in sample
                assert sample in text.splitlines()


class TestSecureLogIsNotConsumed:
    def test_hashing_does_not_mutate_the_log(self):
        """fill() used to assign its generalised form back onto the entry,
        so hashing a log destroyed it for every later reader."""
        from crunchtools.CrunchLog import CrunchLog
        from crunchtools.LogHash import SuperHash

        log = CrunchLog.from_text(secure_log())
        before = [entry.log_entry for entry in log]
        SuperHash.manufacture(log, "hash.stopwords")
        assert [entry.log_entry for entry in log] == before


class TestSampleLineNumbers:
    """Grouping reorders by definition. A caller that wants to present
    samples in written order needs to know where they came from."""

    def test_sample_lines_are_parallel_to_samples(self):
        for group in hash_text(secure_log()):
            assert len(group.sample_lines) == len(group.samples)

    def test_sample_lines_point_at_the_right_lines(self):
        text = secure_log()
        lines = text.splitlines()
        for group in hash_text(text):
            for number, sample in zip(group.sample_lines, group.samples):
                assert lines[number] == sample

    def test_sample_lines_survive_the_degraded_path(self):
        text = secure_log() + "\nan ordinary prose sentence in the stream"
        lines = text.splitlines()
        result = analyze_text(text)
        assert result.degraded is True
        for group in result.groups:
            for number, sample in zip(group.sample_lines, group.samples):
                assert lines[number] == sample


class TestCallerSuppliedStopwords:
    """Normalisation policy belongs to whoever reads the output. The
    packaged hash.stopwords is right for system logs and wrong for a caller
    that needs two distinct values to stay distinct."""

    NAMES = "\n".join(
        ["user bob%d logged in" % i for i in range(15)]
        + ["user boa%d logged in" % i for i in range(15)]
    )

    def test_packaged_filter_collapses_adjacent_letters(self):
        """Documents the behaviour that motivates the option: `[a-f]+#`
        eats the letter next to a scrubbed number, so two different names
        share a fingerprint."""
        groups = hash_text(self.NAMES, driver="RawEntry")
        assert len(groups) == 1
        assert groups[0].pattern == "user bo# logged in"

    def test_caller_patterns_keep_distinct_words_distinct(self):
        groups = hash_text(self.NAMES, driver="RawEntry", stopwords=[r"[0-9]+"])
        patterns = {g.pattern for g in groups}
        assert patterns == {"user bob# logged in", "user boa# logged in"}

    def test_caller_patterns_still_normalise_what_they_are_given(self):
        groups = hash_text(self.NAMES, driver="RawEntry", stopwords=[r"[0-9]+"])
        assert sum(g.count for g in groups) == 30
        assert all(g.count == 15 for g in groups)

    def test_empty_pattern_list_means_no_normalisation(self):
        groups = hash_text(self.NAMES, driver="RawEntry", stopwords=[])
        assert len(groups) == 30

    def test_stopwords_override_filter_name(self):
        groups = hash_text(
            self.NAMES,
            driver="RawEntry",
            filter_name="hash.stopwords",
            stopwords=[r"[0-9]+"],
        )
        assert len(groups) == 2

    def test_samples_are_still_verbatim_with_caller_patterns(self):
        lines = self.NAMES.splitlines()
        for group in hash_text(self.NAMES, driver="RawEntry", stopwords=[r"[0-9]+"]):
            for number, sample in zip(group.sample_lines, group.samples):
                assert lines[number] == sample


class TestPatternReplacements:
    """A fingerprint that says what it normalised away is worth more than
    one that only says something was there."""

    TEXT = "\n".join(
        "2026-09-19T04:00:%02d host sshd[%d]: login from 10.0.0.%d" % (i, i, i)
        for i in range(30)
    )
    RULES = [
        (r"\d{4}-\d{2}-\d{2}T\d{2}:\d{2}:\d{2}", "<TS>"),
        (r"\b(?:\d{1,3}\.){3}\d{1,3}\b", "<IP>"),
        (r"\d+", "<N>"),
    ]

    def test_replacements_appear_in_the_pattern(self):
        groups = hash_text(self.TEXT, driver="RawEntry", stopwords=self.RULES)
        assert len(groups) == 1
        assert groups[0].pattern == "<TS> host sshd[<N>]: login from <IP>"

    def test_bare_regexes_still_scrub_to_hash(self):
        groups = hash_text(self.TEXT, driver="RawEntry", stopwords=[r"\d+"])
        assert groups[0].pattern == "#-#-#T#:#:# host sshd[#]: login from #.#.#.#"

    def test_bare_and_paired_rules_can_be_mixed(self):
        groups = hash_text(
            self.TEXT, driver="RawEntry",
            stopwords=[(r"\b(?:\d{1,3}\.){3}\d{1,3}\b", "<IP>"), r"\d+"],
        )
        assert groups[0].pattern == "#-#-#T#:#:# host sshd[#]: login from <IP>"

    def test_rule_order_is_preserved(self):
        """Specific before generic, or an ISO timestamp becomes six <N>s."""
        reversed_rules = list(reversed(self.RULES))
        groups = hash_text(self.TEXT, driver="RawEntry", stopwords=reversed_rules)
        assert "<TS>" not in groups[0].pattern
