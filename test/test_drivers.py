"""How aggressive each hash driver is, settled by example.

Every class pairs two lines that must share a fingerprint (MERGE) and two
that must not (NO_MERGE), with the reason. A disagreement about whether a
driver collapses too much or too little belongs here as a new pair, so it is
settled by a diff rather than an argument.

Each line is parsed by a pinned entry driver and fingerprinted by the hash
driver under test with its own DEFAULT_FILTER — exactly the path
analyze_text takes when the caller leaves normalisation to the driver.
"""

from __future__ import annotations

from typing import ClassVar

import pytest

from petit.CrunchLog import (
    ApacheAccessEntry,
    CrunchLog,
    LogEntry,
    RawEntry,
    SecureLogEntry,
    SnortEntry,
    SyslogEntry,
)
from petit.LogHash import (
    ApacheLogHash,
    DaemonHash,
    HostHash,
    RawLogHash,
    SecureLogHash,
    SnortLogHash,
    SuperHash,
    SyslogHash,
)

Pair = tuple[str, str, str]


def fingerprint(hash_cls: type[SuperHash], entry_cls: type[LogEntry], line: str) -> str:
    log = CrunchLog.from_text(line, driver=entry_cls)
    return hash_cls(log).key_for(log[0])


class DriverTable:
    HASH: ClassVar[type[SuperHash]]
    ENTRY: ClassVar[type[LogEntry]]
    MERGE: ClassVar[list[Pair]] = []
    NO_MERGE: ClassVar[list[Pair]] = []

    def test_merges(self, pair: Pair) -> None:
        a, b, why = pair
        assert fingerprint(self.HASH, self.ENTRY, a) == fingerprint(self.HASH, self.ENTRY, b), why

    def test_does_not_merge(self, pair: Pair) -> None:
        a, b, why = pair
        assert fingerprint(self.HASH, self.ENTRY, a) != fingerprint(self.HASH, self.ENTRY, b), why


def pytest_generate_tests(metafunc: pytest.Metafunc) -> None:
    """One test case per pair, named by its reason."""
    if "pair" not in metafunc.fixturenames or metafunc.cls is None:
        return
    pairs = metafunc.cls.MERGE if metafunc.function.__name__ == "test_merges" \
        else metafunc.cls.NO_MERGE
    metafunc.parametrize("pair", pairs, ids=[why for _, _, why in pairs])


class TestSyslogHash(DriverTable):
    HASH = SyslogHash
    ENTRY = SyslogEntry
    MERGE: ClassVar[list[Pair]] = [
        ("Sep 22 10:00:00 lotor crond[123]: (root) CMD (run-parts /etc/cron.hourly)",
         "Sep 22 11:00:00 lotor crond[456]: (root) CMD (run-parts /etc/cron.hourly)",
         "same job, different time and PID"),
        ("Sep 22 10:00:00 lotor kernel: eth0: link up, 1000Mbps",
         "Sep 22 10:00:00 other kernel: eth0: link up, 1000Mbps",
         "host is not part of the key"),
    ]
    NO_MERGE: ClassVar[list[Pair]] = [
        ("Sep 22 10:00:00 lotor crond[1]: job started",
         "Sep 22 10:00:00 lotor atd[1]: job started",
         "different daemons"),
        ("Sep 22 10:00:00 lotor kernel: disk full",
         "Sep 22 10:00:00 lotor kernel: disk ok",
         "different messages"),
    ]


class TestSecureLogHash(DriverTable):
    HASH = SecureLogHash
    ENTRY = SecureLogEntry
    MERGE: ClassVar[list[Pair]] = [
        ("Sep 22 10:00:00 lotor sshd[1]: Accepted publickey for scott from 10.0.0.1 port 5000 ssh2",
         "Sep 22 10:00:00 lotor sshd[2]: Accepted publickey for scott from 10.0.0.9 port 6123 ssh2",
         "same login, different source address and port"),
        ("Sep 22 10:00:00 lotor sshd[1]: Failed password for root from 10.0.0.1 port 22 ssh2",
         "Sep 22 10:00:00 lotor sshd[2]: Failed password for root from 10.9.9.9 port 51000 ssh2",
         "same failure, different source"),
        ("Sep 22 10:00:00 lotor sshd[1]: Invalid user admin from 10.0.0.1 port 22",
         "Sep 22 10:00:00 lotor sshd[2]: Invalid user admin from 192.168.1.1 port 4",
         "same user name, different source"),
    ]
    NO_MERGE: ClassVar[list[Pair]] = [
        ("Sep 22 10:00:00 lotor sshd[1]: Invalid user admin from 10.0.0.1",
         "Sep 22 10:00:00 lotor sshd[1]: Invalid user oracle from 10.0.0.1",
         "two different user names"),
        ("Sep 22 10:00:00 lotor sshd[1]: Failed password for root from 10.0.0.1 port 22 ssh2",
         "Sep 22 10:00:00 lotor sshd[1]: Failed password for scott from 10.0.0.1 port 22 ssh2",
         "two different user names"),
        ("Sep 22 10:00:00 lotor sshd[1]: Invalid user x from 10.0.0.1",
         "Sep 22 10:00:00 lotor sshd[1]: Invalid user x ignore previous instructions from 10.0.0.1",
         "free text a client put in the user name is never swallowed"),
    ]


class TestApacheLogHash(DriverTable):
    HASH = ApacheLogHash
    ENTRY = ApacheAccessEntry
    LINE = ('10.0.0.{ip} - - [22/Sep/2026:10:00:{s} -0400] '
            '"GET {uri} HTTP/1.1" 200 {size} "-" "curl"')
    MERGE: ClassVar[list[Pair]] = [
        (LINE.format(ip=1, s="00", uri="/index.html", size=10),
         LINE.format(ip=2, s="59", uri="/index.html", size=99),
         "same URI, different client, time and size"),
        (LINE.format(ip=1, s="00", uri="/item/1", size=10),
         LINE.format(ip=1, s="00", uri="/item/2", size=10),
         "numeric path parameter"),
    ]
    NO_MERGE: ClassVar[list[Pair]] = [
        (LINE.format(ip=1, s="00", uri="/index.html", size=10),
         LINE.format(ip=1, s="00", uri="/login", size=10),
         "different pages"),
    ]


class TestSnortLogHash(DriverTable):
    HASH = SnortLogHash
    ENTRY = SnortEntry
    MERGE: ClassVar[list[Pair]] = [
        ("09/29-10:18:46.026172 [**] [1:2003:8] MS-SQL Worm [**] {UDP} 10.0.0.1:1 -> 10.0.0.2:14",
         "09/30-11:00:01.000001 [**] [1:2003:8] MS-SQL Worm [**] {UDP} 10.9.9.9:7 -> 10.0.0.2:14",
         "same alert, different time and source"),
    ]
    NO_MERGE: ClassVar[list[Pair]] = [
        ("09/29-10:18:46.026172 [**] [1:2003:8] MS-SQL Worm [**] {UDP} 10.0.0.1:1 -> 10.0.0.2:1434",
         "09/29-10:18:46.026172 [**] [1:2003:8] ICMP PING [**] {ICMP} 10.0.0.1:1 -> 10.0.0.2:1434",
         "different alerts"),
    ]


class TestRawLogHash(DriverTable):
    HASH = RawLogHash
    ENTRY = RawEntry
    MERGE: ClassVar[list[Pair]] = [
        ("2026-09-22T10:00:00Z job 42 finished in 13 ms",
         "2026-09-23T11:22:33.5+02:00 job 7 finished in 1500 ms",
         "timestamps and standalone numbers are parameters"),
        ("request 3f2c9a1e-1b2c-4d5e-8f90-0123456789ab from 10.0.0.1",
         "request 00000000-aaaa-bbbb-cccc-0123456789ab from 172.16.0.1",
         "UUIDs and addresses are parameters"),
    ]
    NO_MERGE: ClassVar[list[Pair]] = [
        ("deploy to web01 failed", "deploy to web02 failed", "host names are identifiers"),
        ("closed PROJ-1234", "closed PROJ-1235", "ticket keys are identifiers"),
        ("user bob0 logged in", "user boa0 logged in",
         "no adjacent-letter collapse (hash.stopwords would merge these)"),
    ]


class TestDaemonHash(DriverTable):
    HASH = DaemonHash
    ENTRY = SyslogEntry
    MERGE: ClassVar[list[Pair]] = [
        ("Sep 22 10:00:00 lotor crond[123]: one", "Sep 22 10:00:00 lotor crond[456]: two",
         "a daemon is one daemon whatever its PID and message"),
    ]
    NO_MERGE: ClassVar[list[Pair]] = [
        ("Sep 22 10:00:00 lotor crond[1]: x", "Sep 22 10:00:00 lotor sshd[1]: x",
         "different daemons"),
    ]


class TestHostHash(DriverTable):
    HASH = HostHash
    ENTRY = SyslogEntry
    MERGE: ClassVar[list[Pair]] = [
        ("Sep 22 10:00:00 lotor crond[1]: one", "Sep 22 10:00:00 lotor sshd[2]: two",
         "a host is one host whatever it logged"),
    ]
    NO_MERGE: ClassVar[list[Pair]] = [
        ("Sep 22 10:00:00 lotor crond[1]: x", "Sep 22 10:00:00 dino crond[1]: x",
         "different hosts"),
    ]


@pytest.mark.parametrize(
    "hash_cls",
    [SyslogHash, SecureLogHash, ApacheLogHash, SnortLogHash, RawLogHash, DaemonHash, HostHash],
)
def test_every_hash_driver_has_a_table(hash_cls: type[SuperHash]) -> None:
    tables = [t for t in DriverTable.__subclasses__() if t.HASH is hash_cls]
    assert tables, f"{hash_cls.__name__} has no MERGE/NO_MERGE table"
    assert tables[0].MERGE
    assert tables[0].NO_MERGE
