"""Library API: text in, data out, exceptions on failure."""

import pytest

from crunchtools import (
    EmptyLogError,
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

    def test_samples_are_readable_lines_not_object_reprs(self):
        """Samples must carry the envelope — host, daemon, timestamp — or
        they tell the caller nothing a count did not already say.

        Note they are NOT verbatim: SecureLogHash rewrites log_entry in place
        while fingerprinting, so the payload half may arrive generalised.
        """
        top = hash_text(secure_log())[0]
        assert top.samples
        sample = top.samples[0]
        assert "object at 0x" not in sample
        assert "lotor" in sample and "sshd" in sample

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
