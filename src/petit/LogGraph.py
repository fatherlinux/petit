from __future__ import annotations

import datetime
import logging
import sys
from collections import UserDict
from math import ceil
from typing import TYPE_CHECKING

from .errors import EmptyLogError

if TYPE_CHECKING:
    from .CrunchLog import CrunchLog

# Calendar constants used to size and label graphs.
HOURS_PER_DAY = 24
MONTHS_PER_YEAR = 12
DAYS_PER_YEAR = 365
# Not a true calendar constant — how many days DaysGraph shows (roughly a month).
DAYS_GRAPH_WINDOW = 31
# GraphHash.display() prints the year's last two digits on the x-axis.
YEAR_LABEL_MODULUS = 2000


class GraphHash(UserDict[str, int]):
    """Interface class used to control structure & use of all GraphHash subtypes"""

    start_date: datetime.date = datetime.date.today()
    end_date: datetime.date = datetime.date.today()
    middle_date: datetime.date
    max_value = 0
    min_value = 0
    second: int | str = 0
    minute: int | str = 0
    hour: int | str = 0
    day: int | str = 0
    month: int | str = 0
    year: int | str = 0
    scale = 0.0
    tick = "#"
    # Set by the CLI after construction (`x.wide = options.wide`); never
    # mutated by GraphHash itself.
    wide = False
    duration: int = 0
    unit = ""

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
        graph_position: dict[str, float] = {}
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
                    print(graph_min_value)

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
            graph_position["middle"] = graph_width / 2 - ((graph_width / 2) % 2)
            graph_position["end"] = graph_width - 3

        else:

            # Calculate Positions
            graph_position["begin"] = 1
            graph_position["middle"] = graph_width / 2
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

    def __init__(self, log: CrunchLog) -> None:

        # Call parent init
        UserDict.__init__(self)

        # Turn first line into syslog
        if len(log) > 0:
            first_entry = log[0]
        else:
            raise EmptyLogError("no entries to graph")

        # Local Variables
        self.second = first_entry.second
        self.minute = first_entry.minute
        self.hour = first_entry.hour
        self.day = first_entry.day
        self.month = str(first_entry.month)
        self.year = first_entry.year
        self.unit = "second"
        self.duration = 60

        start_date = datetime.datetime(
            int(self.year), int(self.month), int(self.day),
            int(self.hour), int(self.minute), int(self.second),
        )
        middle_date = start_date

        # Zero out each entry, this will fill in blanks which
        # may be in the log, especially sparse logs.
        for i in range(self.duration):

            # Calculate the current date, the last one will be the end date
            end_date = start_date + datetime.timedelta(seconds=i)
            end_key = (
                f"{end_date.year}{end_date.month:02d}{end_date.day:02d}"
                f"{end_date.hour:02d}{end_date.minute:02d}{end_date.second:02d}"
            )
            self.zero(end_key)

            # Check for middle date and save
            if i == (self.duration / 2):
                middle_date = end_date

        # Save final values
        self.start_date = start_date
        self.middle_date = middle_date
        self.end_date = end_date

        for entry in log:

            # Create key rooted in time
            key = entry.year + entry.month + entry.day + entry.hour + entry.minute + entry.second

            # Check to make sure key is found in the list built above
            if key in list(self.keys()):
                self.increment(key)

        self.build_calculations()


class MinutesGraph(GraphHash):
    """60 minute graph subtype"""

    def __init__(self, log: CrunchLog) -> None:

        # Call parent init
        UserDict.__init__(self)

        # Turn first line into syslog
        if len(log) > 0:
            first_entry = log[0]
        else:
            raise EmptyLogError("no entries to graph")

        # Local Variables
        self.second = 0
        self.minute = first_entry.minute
        self.hour = first_entry.hour
        self.day = first_entry.day
        self.month = str(first_entry.month)
        self.year = first_entry.year
        self.unit = "minute"
        self.duration = 60

        start_date = datetime.datetime(
            int(self.year), int(self.month), int(self.day),
            int(self.hour), int(self.minute), int(self.second),
        )
        middle_date = start_date

        # Zero out each entry, this will fill in blanks which
        # may be in the log, especially sparse logs.
        for i in range(self.duration):

            # Calculate the current date, the last one will be the end date
            end_date = start_date + datetime.timedelta(minutes=i)
            end_key = (
                f"{end_date.year}{end_date.month:02d}{end_date.day:02d}"
                f"{end_date.hour:02d}{end_date.minute:02d}"
            )
            self.zero(end_key)

            # Check for middle date and save
            if i == (self.duration / 2):
                middle_date = end_date

        # Save final values
        self.start_date = start_date
        self.middle_date = middle_date
        self.end_date = end_date

        for entry in log:

            # Create key rooted in time
            key = entry.year + entry.month + entry.day + entry.hour + entry.minute

            # Check to make sure key is found in the list built above
            if key in list(self.keys()):
                self.increment(key)

        self.build_calculations()


class HoursGraph(GraphHash):
    """24 hour graph subtype"""

    def __init__(self, log: CrunchLog) -> None:

        # Call parent init
        UserDict.__init__(self)

        # Turn first line into syslog
        if len(log) > 0:
            first_entry = log[0]
        else:
            raise EmptyLogError("no entries to graph")

        # Local Variables
        self.second = 0
        self.minute = 0
        self.hour = first_entry.hour
        self.day = first_entry.day
        self.month = str(first_entry.month)
        self.year = first_entry.year
        self.unit = "hour"
        self.duration = HOURS_PER_DAY

        start_date = datetime.datetime(
            int(self.year), int(self.month), int(self.day),
            int(self.hour), int(self.minute), int(self.second),
        )
        middle_date = start_date

        # Zero out each entry, this will fill in blanks which
        # may be in the log, especially sparse logs.
        for i in range(self.duration):

            # Calculate the current date, the last one will be the end date
            end_date = start_date + datetime.timedelta(hours=i)
            end_key = f"{end_date.year}{end_date.month:02d}{end_date.day:02d}{end_date.hour:02d}"
            self.zero(end_key)

            # Check for middle date and save
            if i == (self.duration / 2):
                middle_date = end_date

        # Save final values
        self.start_date = start_date
        self.middle_date = middle_date
        self.end_date = end_date

        for entry in log:

            # Create key rooted in time
            key = entry.year + entry.month + entry.day + entry.hour

            # Check to make sure key is found in the list built above
            if key in list(self.keys()):
                self.increment(key)

        self.build_calculations()


class DaysGraph(GraphHash):
    """30 day graph subtype"""

    def __init__(self, log: CrunchLog) -> None:

        # Call parent init
        UserDict.__init__(self)

        # Turn first line into syslog
        if len(log) > 0:
            first_entry = log[0]
        else:
            raise EmptyLogError("no entries to graph")

        # Local Variables
        self.second = 0
        self.minute = 0
        self.hour = 0
        self.day = first_entry.day
        self.month = str(first_entry.month)
        self.year = first_entry.year
        self.unit = "day"
        self.duration = DAYS_GRAPH_WINDOW

        start_date = datetime.datetime(
            int(self.year), int(self.month), int(self.day),
            int(self.hour), int(self.minute), int(self.second),
        )
        middle_date = start_date

        # Zero out each entry, this will fill in blanks which
        # may be in the log, especially sparse logs.
        for i in range(self.duration):

            # Calculate the current date, the last one will be the end date
            end_date = start_date + datetime.timedelta(days=i)
            end_key = f"{end_date.year}{end_date.month:02d}{end_date.day:02d}"
            self.zero(end_key)

            # Check for middle date and save
            if i == (int(self.duration / 2)):
                middle_date = end_date

        # Save final values
        self.start_date = start_date
        self.middle_date = middle_date
        self.end_date = end_date

        for entry in log:

            # Create key rooted in time
            key = entry.year + entry.month + entry.day

            # Check to make sure key is found in the list built above
            if key in list(self.keys()):
                self.increment(key)

        self.build_calculations()


class MonthsGraph(GraphHash):
    """12 month graph subtype"""

    def __init__(self, log: CrunchLog) -> None:

        # Call parent init
        UserDict.__init__(self)

        # Turn first line into syslog
        if len(log) > 0:
            first_entry = log[0]
        else:
            raise EmptyLogError("no entries to graph")

        # Local Variables
        self.second = 0
        self.minute = 0
        self.hour = 0
        self.day = 1
        self.month = str(first_entry.month)
        self.year = first_entry.year
        self.unit = "month"
        self.duration = MONTHS_PER_YEAR

        start_date = datetime.datetime(
            int(self.year), int(self.month), int(self.day),
            int(self.hour), int(self.minute), int(self.second),
        )
        middle_date = start_date

        # Zero out each entry, this will fill in blanks which
        # may be in the log, especially sparse logs.
        for i in range(self.duration):

            # Calculate the current date, the last one will be the end date
            end_date = start_date + datetime.timedelta(days=i * DAYS_PER_YEAR / MONTHS_PER_YEAR + 1)
            end_key = f"{end_date.year}{end_date.month:02d}"
            self.zero(end_key)
            logging.debug("End Date: " + str(end_date))
            logging.debug("End Key: " + end_key)

            # Check for middle date and save
            if i == (self.duration / 2):
                middle_date = end_date

        # Save final values
        self.start_date = start_date
        self.middle_date = middle_date
        self.end_date = end_date

        for entry in log:

            # Create key rooted in time
            key = entry.year + entry.month

            # Check to make sure key is found in the list built above
            if key in list(self.keys()):
                self.increment(key)

        self.build_calculations()


class YearsGraph(GraphHash):
    """10 year graph subtype"""

    def __init__(self, log: CrunchLog) -> None:

        # Call parent init
        UserDict.__init__(self)

        # Turn first line into syslog
        if len(log) > 0:
            first_entry = log[0]
        else:
            raise EmptyLogError("no entries to graph")

        # Local Variables
        self.second = 0
        self.minute = 0
        self.hour = 0
        self.day = 1
        self.month = 1
        self.year = first_entry.year
        self.unit = "year"
        self.duration = 10

        start_date = datetime.datetime(
            int(self.year), int(self.month), int(self.day),
            int(self.hour), int(self.minute), int(self.second),
        )
        middle_date = start_date

        # Zero out each entry, this will fill in blanks which
        # may be in the log, especially sparse logs.
        for i in range(self.duration):

            # Calculate the current date, the last one will be the end date
            end_date = start_date + datetime.timedelta(days=i * DAYS_PER_YEAR)
            end_key = str(end_date.year)
            self.zero(end_key)

            # Check for middle date and save
            if i == (self.duration / 2):
                middle_date = end_date

        # Save final values
        self.start_date = start_date
        self.middle_date = middle_date
        self.end_date = end_date

        for entry in log:

            # Create key rooted in time
            key = entry.year

            # Check to make sure key is found in the list built above
            if key in list(self.keys()):
                self.increment(key)

        self.build_calculations()
