"""Window arithmetic behind the time graphs."""

from __future__ import annotations

import datetime

from petit.CrunchLog import CrunchLog
from petit.LogGraph import MonthsGraph, YearsGraph, _step


def test_months_step_on_the_calendar_across_a_year_boundary() -> None:
    start = datetime.datetime(2025, 11, 1)
    assert [_step(start, "month", i).strftime("%Y-%m") for i in (0, 1, 2, 11)] == \
        ["2025-11", "2025-12", "2026-01", "2026-10"]


def test_years_step_on_the_calendar_across_leap_days() -> None:
    start = datetime.datetime(2009, 1, 1)
    assert _step(start, "year", 9) == datetime.datetime(2018, 1, 1)


def _log(text: str) -> CrunchLog:
    return CrunchLog.from_text(text)


APACHE = (
    '127.0.0.1 - - [15/Nov/2025:10:00:00 -0500] "GET / HTTP/1.1" 200 1 "-" "-"\n'
    '127.0.0.1 - - [03/Jan/2026:10:00:00 -0500] "GET / HTTP/1.1" 200 1 "-" "-"\n'
)


def test_month_graph_has_a_bucket_for_every_month() -> None:
    graph = MonthsGraph(_log(APACHE))
    assert len(graph) == 12
    assert graph["202511"] == 1
    assert graph["202601"] == 1
    assert graph.end_date == datetime.datetime(2026, 10, 1)


def test_year_graph_has_a_bucket_for_every_year() -> None:
    graph = YearsGraph(_log(APACHE))
    assert sorted(graph) == [str(y) for y in range(2025, 2035)]
