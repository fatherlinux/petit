from __future__ import annotations

import datetime
import logging
import sys
from collections import UserDict
from math import ceil
from typing import TYPE_CHECKING

from .errors import EmptyLogError

if TYPE_CHECKING:
    from .CrunchLog import CrunchLog, LogEntry

# Calendar constants used to size and label graphs.
HOURS_PER_DAY = 24
MONTHS_PER_YEAR = 12
# Not a true calendar constant — how many days DaysGraph shows (roughly a month).
DAYS_GRAPH_WINDOW = 31
# GraphHash.display() prints the year's last two digits on the x-axis.
YEAR_LABEL_MODULUS = 2000
# set_abnormal()/set_blank() stamp unparseable lines with this year.
SENTINEL_YEAR = 1900

# Timestamp fields, coarsest first. A graph in unit U buckets on the fields up
# to and including U; everything finer is floored away.
_FIELDS = ("year", "month", "day", "hour", "minute", "second")


def _entry_time(entry: LogEntry, unit: str) -> datetime.datetime:
    """The entry's timestamp floored to `unit`."""
    depth = _FIELDS.index(unit) + 1
    parts = [int(getattr(entry, f)) for f in _FIELDS[:depth]]
    # month and day floor to 1, the clock fields to 0
    parts += [1, 1, 0, 0, 0][depth - 1:]
    year, month, day, hour, minute, second = parts
    return datetime.datetime(year, month, day, hour, minute, second)


def _entry_key(entry: LogEntry, unit: str) -> str:
    return "".join(getattr(entry, f) for f in _FIELDS[:_FIELDS.index(unit) + 1])


def _time_key(when: datetime.datetime, unit: str) -> str:
    # Same shape _entry_key builds from the drivers' zero-padded fields.
    return when.strftime("%Y%m%d%H%M%S")[:4 + 2 * _FIELDS.index(unit)]


def _step(start: datetime.datetime, unit: str, i: int) -> datetime.datetime:
    """`start` moved forward `i` units, on the calendar for months and years."""
    if unit == "year":
        return start.replace(year=start.year + i)
    if unit == "month":
        months = start.month - 1 + i
        return start.replace(year=start.year + months // MONTHS_PER_YEAR,
                             month=months % MONTHS_PER_YEAR + 1)
    return start + datetime.timedelta(**{unit + "s": i})


class GraphHash(UserDict[str, int]):
    """A count of entries per unit of time, over a fixed window that starts
    at the first entry. Subclasses pick the unit and the default window."""

    start_date: datetime.datetime
    end_date: datetime.datetime
    middle_date: datetime.datetime
    max_value = 0
    min_value = 0
    scale = 0.0
    tick = "#"
    # Set by the CLI after construction (`x.wide = options.wide`); never
    # mutated by GraphHash itself.
    wide = False
    duration: int = 0
    unit = ""

    def __init__(self, log: CrunchLog, duration: int | None = None) -> None:
        UserDict.__init__(self)

        if len(log) == 0:
            raise EmptyLogError("no entries to graph")

        if duration is not None:
            self.duration = duration

        # Zero out each entry, this will fill in blanks which
        # may be in the log, especially sparse logs.
        self.start_date = _entry_time(log[0], self.unit)
        for i in range(self.duration):
            self.end_date = _step(self.start_date, self.unit, i)
            self.zero(_time_key(self.end_date, self.unit))
            if i == self.duration // 2:
                self.middle_date = self.end_date

        for entry in log:
            key = _entry_key(entry, self.unit)
            if key in self:
                self.increment(key)

        self.build_calculations()

    def increment(self, key: str) -> None:
        """Adds new entry. Similar to append method on list"""

        # Check to make sure it exists
        if key not in self:
            self[key] = 0

        # Increment the hashed count
        self[key] += 1

    def zero(self, key: str) -> None:
        """Creates empty entry"""

        # Check to make sure it exists
        if key not in self:
            self[key] = 0

    def build_calculations(self) -> None:
        """Calculates and saves important graph information"""

        # find max value of any key
        for key in list(self.keys()):
            self.max_value = max(self.max_value, self[key])

        # find the minimum value of any key
        self.min_value = self.max_value
        for key in list(self.keys()):
            self.min_value = min(self.min_value, self[key])

    def display(self) -> None:
        """Common display function used by all graph subtypes"""

        # Declarations & Variables
        graph_height = 6
        graph_width = len(self)
        scale = float(float(self.max_value - self.min_value) / float(graph_height))
        graph_position: dict[str, int] = {}
        graph_value: dict[str, int] = {}

        # Debug output
        logging.debug("length: " + str(graph_width))

        # Use wide scale or small scale
        if self.wide:
            char_fill = self.tick + " "
            char_blank = "  "
        else:
            char_fill = self.tick
            char_blank = " "

        # Calculate the graph min/max, so that the information is better normalized
        graph_max_value = self.max_value

        # Find the real minimum, could very well be zero
        graph_min_value: float = self.max_value
        for key in list(self.keys()):
            graph_min_value = min(graph_min_value, self[key])

        if graph_min_value == 0:

            # Recalculate
            graph_min_value = self.max_value
            for key in list(self.keys()):
                if self[key] < graph_min_value and self[key] != 0:
                    graph_min_value = self[key] / 2

        # Normalize data
        for key in list(self.keys()):
            if self[key] > 0:

                # Ensure difference between min/max or don't normalize
                if graph_max_value > graph_min_value:
                    self[key] = ceil(
                        (float(self[key] - graph_min_value)
                         / float(graph_max_value - graph_min_value)) * graph_height
                    )

                # Normalize because of difference between min/max
                else:
                    self[key] = ceil((float(self[key]) / float(graph_max_value)) * graph_height)

        # Start Graph Printing
        print()

        # Print out the dictionary first sorted by the word with
        # the most entries with an alphabetical subsort
        for i in reversed(list(range(1, graph_height))):
            for key in sorted(self.keys()):

                if self[key] >= i:
                    sys.stdout.write(char_fill)
                else:
                    sys.stdout.write(char_blank)
            print()

        # Print line of '#' charachters at bottom of screen
        for _ in range(len(self)):
            sys.stdout.write(char_fill)
        print()

        if self.wide:

            graph_width = graph_width * 2

            # Calculate Positions
            graph_position["begin"] = 1
            graph_position["middle"] = graph_width // 2 - ((graph_width // 2) % 2)
            graph_position["end"] = graph_width - 3

        else:

            # Calculate Positions
            graph_position["begin"] = 1
            graph_position["middle"] = graph_width // 2
            graph_position["end"] = graph_width - 2

        # Calculate Values
        graph_value["begin"] = getattr(self.start_date, self.unit)
        graph_value["middle"] = getattr(self.middle_date, self.unit)
        graph_value["end"] = getattr(self.end_date, self.unit)

        # Draw numbers at bottom of the screen
        for i in range(1, graph_width):

            # Beginning
            if i == graph_position["begin"]:
                sys.stdout.write(f"{graph_value['begin'] % YEAR_LABEL_MODULUS:02d}")
            # Half
            elif i == graph_position["middle"]:
                sys.stdout.write(f"{graph_value['middle'] % YEAR_LABEL_MODULUS:02d}")
            # Last
            elif i == graph_position["end"]:
                sys.stdout.write(f"{graph_value['end'] % YEAR_LABEL_MODULUS:02d}")
            else:
                sys.stdout.write(" ")
        print()

        print()
        print("Start Time:\t", str(self.start_date), "\t\tMinimum Value:", self.min_value)
        print("End Time:\t", str(self.end_date), "\t\tMaximum Value:", self.max_value)
        print("Duration:\t", str(self.duration), self.unit + "s", "\t\t\tScale:", str(scale))
        print()




class SecondsGraph(GraphHash):
    """60 second graph subtype"""
    unit = "second"
    duration = 60


class MinutesGraph(GraphHash):
    """60 minute graph subtype"""
    unit = "minute"
    duration = 60


class HoursGraph(GraphHash):
    """24 hour graph subtype"""
    unit = "hour"
    duration = HOURS_PER_DAY


class DaysGraph(GraphHash):
    """31 day graph subtype"""
    unit = "day"
    duration = DAYS_GRAPH_WINDOW


class MonthsGraph(GraphHash):
    """12 month graph subtype"""
    unit = "month"
    duration = MONTHS_PER_YEAR


class YearsGraph(GraphHash):
    """10 year graph subtype"""
    unit = "year"
    duration = 10


# Finest first: auto_graph() takes the first one whose window fits the log.
GRAPHS: tuple[type[GraphHash], ...] = (
    SecondsGraph, MinutesGraph, HoursGraph, DaysGraph, MonthsGraph, YearsGraph,
)
GRAPH_FOR_UNIT: dict[str, type[GraphHash]] = {g.unit: g for g in GRAPHS}


def auto_graph(log: CrunchLog) -> type[GraphHash]:
    """The finest fixed graph whose window, starting at the first entry,
    reaches the latest entry. Falls back to YearsGraph.

    Lines stamped with the sentinel year by set_abnormal() carry no real time,
    so they don't stretch the span unless the log itself starts there.
    """
    if len(log) == 0:
        raise EmptyLogError("no entries to graph")

    first = _entry_time(log[0], "second")
    latest = first
    for entry in log:
        try:
            when = _entry_time(entry, "second")
        except ValueError:
            continue
        if when.year == SENTINEL_YEAR and first.year != SENTINEL_YEAR:
            continue
        latest = max(latest, when)

    for graph in GRAPHS:
        start = _entry_time(log[0], graph.unit)
        if latest < _step(start, graph.unit, graph.duration):
            return graph
    return YearsGraph
