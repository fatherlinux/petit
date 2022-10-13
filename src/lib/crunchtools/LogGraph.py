from collections import UserDict
from math import ceil
import datetime
import sys
import logging

class GraphHash(UserDict):
    """Interface class used to control structure & use of all GraphHash subtypes"""

    start_date = datetime.date.today()
    end_date = datetime.date.today()
    max_value = 0
    min_value = 0
    second = 0
    minute = 0
    hour = 0
    day = 0
    month = 0
    year = 0
    scale = 0.0
    tick = "#"
    width = False
    duration = ""
    unit = ""

    def increment(self, key):
        """Adds new entry. Similar to append method on list"""

        # Check to make sure it exists
        if key not in self:
            self[key] = 0

        # Increment the hashed count
        # Create an array of un-hashed values for sampling later
        self[key] += 1

    def zero(self, key):
        """Creates empty entry"""

        # Check to make sure it exists
        if key not in self:
            self[key] = 0

    def build_calculations(self): 
        """Calculates and saves important graph information"""

        # find max value of any key
        for key in list(self.keys()):
            if self[key] > self.max_value:
                self.max_value = self[key]

        # find the minimum value of any key
        self.min_value = self.max_value
        for key in list(self.keys()):
            if self[key] < self.min_value:
                self.min_value = self[key]

    def display(self):
        """Common display function used by all graph subtypes"""

        # Declarations & Variables
        global logging
        graph_height = 6
        graph_width = len(self)
        scale = float(float(self.max_value-self.min_value)/float(graph_height))
        graph_position = {}
        graph_value = {}

        # Debug output
        logging.debug("length: " + str(graph_width))

        # Use wide scale or small scale
        if self.wide:
            char_fill = self.tick+" "
            char_blank = "  "
        else:
            char_fill = self.tick
            char_blank = " "

        # Calculate the graph min/max, so that the information is better normalized    
        graph_min_value = self.min_value
        graph_max_value = self.max_value

        # Find the real minimum, could very well be zero
        graph_min_value = self.max_value
        for key in list(self.keys()):
            if self[key] < graph_min_value:
                graph_min_value = self[key]

        # Check if it should be normalized
        if graph_min_value == 0:

            # Recalculate
            graph_min_value = self.max_value
            for key in list(self.keys()):
                if self[key] < graph_min_value and self[key] != 0:
                    graph_min_value = self[key]/2
                    print(graph_min_value)

        # Normalize data
        for key in list(self.keys()):
            if self[key] > 0:

                # Ensure difference between min/max or don't normalize
                if graph_max_value > graph_min_value:
                    self[key] = ceil((float(self[key]-graph_min_value)/float(graph_max_value-graph_min_value))*graph_height)

                # Normalize because of difference between min/max
                else:
                    self[key] = ceil((float(self[key])/float(graph_max_value))*graph_height)

        # Start Graph Printing
        print()

        # Print out the dictionary first sorted by the word with
        # the most entries with an alphabetical subsort
        for i in reversed(list(range(1,graph_height))):
            for key in sorted(self.keys()):
                    
                if self[key] >= i:
                    sys.stdout.write(char_fill)
                else:
                    sys.stdout.write(char_blank)
            print()

        # Print line of '#' charachters at bottom of screen
        for key in list(self.keys()):
            sys.stdout.write(char_fill)
        print()

        # Determine numbers for normal and wide graphs
        if self.wide:

            graph_width = graph_width*2

            # Calculate Positions
            graph_position["begin"] = 1
            graph_position["middle"] = graph_width/2 - ((graph_width/2) % 2)
            graph_position["end"]= graph_width-3

        else:

            # Calculate Positions
            graph_position["begin"] = 1
            graph_position["middle"] = graph_width/2
            graph_position["end"] = graph_width-2

        # Calculate Values
        graph_value["begin"] = eval("self.start_date."+self.unit)
        graph_value["middle"] = eval("self.middle_date."+self.unit)
        graph_value["end"] = eval("self.end_date."+self.unit)

        # Draw numbers at bottom of the screen            
        for i in range(1,graph_width):

            # Beginning
            if i == graph_position["begin"]:
                sys.stdout.write(str("%.2d" % (graph_value["begin"] % 2000)))
            # Half
            elif i == graph_position["middle"]:
                sys.stdout.write(str("%.2d" % (graph_value["middle"] % 2000)))
            # Last
            elif i == graph_position["end"]:
                sys.stdout.write(str("%.2d" % (graph_value["end"] % 2000)))
            else:
                sys.stdout.write(" ")
        print()

        # Create a little space at the top of the screen
        print()
        print("Start Time:\t",str(self.start_date),"\t\tMinimum Value:",self.min_value)
        print("End Time:\t",str(self.end_date),"\t\tMaximum Value:",self.max_value)
        print("Duration:\t",str(self.duration), self.unit+"s","\t\t\tScale:",str(scale))
        print()


class SecondsGraph(GraphHash):
    """60 second graph subtype"""

    def __init__(self, log):

        # Call parent init
        UserDict.__init__(self)

        # Turn first line into syslog
        if len(log) > 0:
            first_entry = log[0]
        else:
            sys.exit()

        # Local Variables
        counter = 0
        self.second = first_entry.second
        self.minute = first_entry.minute
        self.hour = first_entry.hour
        self.day = first_entry.day
        self.month = str(first_entry.month)
        self.year = first_entry.year
        self.unit = "second"
        self.duration = 60

        start_date = datetime.datetime(int(self.year),int(self.month),int(self.day),int(self.hour),int(self.minute),int(self.second))
        start_key = start_date.year+start_date.month+start_date.day+start_date.hour+start_date.minute+start_date.second

        # Zero out each entry, this will fill in blanks which
        # may be in the log, especially sparse logs.
        for i in range(0, self.duration):

            # Calculate the current date, the last one will be the end date
            end_date = start_date + datetime.timedelta(seconds=i)
            end_key = str(end_date.year)+str("%.2d" % (end_date.month))+str("%.2d" % (end_date.day))+str("%.2d" % (end_date.hour))+str("%.2d" % (end_date.minute))+str("%.2d" % (end_date.second))
            self.zero(end_key)

            # Check for middle date and save
            if i == (self.duration/2):
                middle_date = end_date

        # Save final values
        self.start_date = start_date
        self.middle_date = middle_date
        self.end_date = end_date

        # Create a dictionary with an entry for each line. Increment
        # the value for each time the word is found. Merge lines by
        # Removing numbers and replacing them with a single '#'
        for entry in log:

            # Create key rooted in time
            key = entry.year+entry.month+entry.day+entry.hour+entry.minute+entry.second

            # Check to make sure key is found in the list built above
            if key in list(self.keys()):
                self.increment(key)

        self.build_calculations()


class MinutesGraph(GraphHash):
    """60 minute graph subtype"""

    def __init__(self, log):

        # Call parent init
        UserDict.__init__(self)

        # Turn first line into syslog
        if len(log) > 0:
            first_entry = log[0]
        else:
            sys.exit()

        # Local Variables
        counter = 0
        self.second = 0
        self.minute = first_entry.minute
        self.hour = first_entry.hour
        self.day = first_entry.day
        self.month = str(first_entry.month)
        self.year = first_entry.year
        self.unit = "minute"
        self.duration = 60

        start_date = datetime.datetime(int(self.year),int(self.month),int(self.day),int(self.hour),int(self.minute),int(self.second))
        start_key = start_date.year+start_date.month+start_date.day+start_date.hour+start_date.minute

        # Zero out each entry, this will fill in blanks which
        # may be in the log, especially sparse logs.
        for i in range(0, self.duration):

            # Calculate the current date, the last one will be the end date
            end_date = start_date + datetime.timedelta(minutes=i)
            end_key = str(end_date.year)+str("%.2d" % (end_date.month))+str("%.2d" % (end_date.day))+str("%.2d" % (end_date.hour))+str("%.2d" % (end_date.minute))
            self.zero(end_key)

            # Check for middle date and save
            if i == (self.duration/2):
                middle_date = end_date

        # Save final values
        self.start_date = start_date
        self.middle_date = middle_date
        self.end_date = end_date

        # Create a dictionary with an entry for each line. Increment
        # the value for each time the word is found. Merge lines by
        # Removing numbers and replacing them with a single '#'
        for entry in log:

            # Create key rooted in time
            key = entry.year+entry.month+entry.day+entry.hour+entry.minute

            # Check to make sure key is found in the list built above
            if key in list(self.keys()):
                self.increment(key)

        self.build_calculations()


class HoursGraph(GraphHash):
    """24 hour graph subtype"""

    def __init__(self, log):

        # Call parent init
        UserDict.__init__(self)

        # Turn first line into syslog
        if len(log) > 0:
            first_entry = log[0]
        else:
            sys.exit()

        # Local Variables
        counter = 0
        self.second = 0
        self.minute = 0
        self.hour = first_entry.hour
        self.day = first_entry.day
        self.month = str(first_entry.month)
        self.year = first_entry.year
        self.unit = "hour"
        self.duration = 24

        start_date = datetime.datetime(int(self.year),int(self.month),int(self.day),int(self.hour),int(self.minute),int(self.second))
        start_key = start_date.year+start_date.month+start_date.day+start_date.hour

        # Zero out each entry, this will fill in blanks which
        # may be in the log, especially sparse logs.
        for i in range(0, self.duration):

            # Calculate the current date, the last one will be the end date
            end_date = start_date + datetime.timedelta(hours=i)
            end_key = str(end_date.year)+str("%.2d" % (end_date.month))+str("%.2d" % (end_date.day))+str("%.2d" % (end_date.hour))
            self.zero(end_key)

            # Check for middle date and save
            if i == (self.duration/2):
                middle_date = end_date

        # Save final values
        self.start_date = start_date
        self.middle_date = middle_date
        self.end_date = end_date

        # Create a dictionary with an entry for each line. Increment
        # the value for each time the word is found. Merge lines by
        # Removing numbers and replacing them with a single '#'
        for entry in log:

            # Create key rooted in time
            key = entry.year+entry.month+entry.day+entry.hour

            # Check to make sure key is found in the list built above
            if key in list(self.keys()):
                self.increment(key)

        self.build_calculations()


class DaysGraph(GraphHash):
    """30 day graph subtype"""

    def __init__(self, log):

        # Call parent init
        UserDict.__init__(self)

        # Turn first line into syslog
        if len(log) > 0:
            first_entry = log[0]
        else:
            sys.exit()

        # Local Variables
        counter = 0
        self.second = 0
        self.minute = 0
        self.hour = 0
        self.day = first_entry.day
        self.month = str(first_entry.month)
        self.year = first_entry.year
        self.unit = "day"
        self.duration = 31

        start_date = datetime.datetime(int(self.year),int(self.month),int(self.day),int(self.hour),int(self.minute),int(self.second))
        start_key = start_date.year+start_date.month+start_date.day

        # Zero out each entry, this will fill in blanks which
        # may be in the log, especially sparse logs.
        for i in range(0, self.duration):

            # Calculate the current date, the last one will be the end date
            end_date = start_date + datetime.timedelta(days=i)
            end_key = str(end_date.year)+str("%.2d" % (end_date.month))+str("%.2d" % (end_date.day))
            self.zero(end_key)

            # Check for middle date and save
            if i == (int(self.duration/2)):
                middle_date = end_date

        # Save final values
        self.start_date = start_date
        self.middle_date = middle_date
        self.end_date = end_date

        # Create a dictionary with an entry for each line. Increment
        # the value for each time the word is found. Merge lines by
        # Removing numbers and replacing them with a single '#'
        for entry in log:

            # Create key rooted in time
            key = entry.year+entry.month+entry.day

            # Check to make sure key is found in the list built above
            if key in list(self.keys()):
                self.increment(key)

        self.build_calculations()


class MonthsGraph(GraphHash):
    """12 month graph subtype"""

    def __init__(self, log):

        # Call parent init
        UserDict.__init__(self)

        # Turn first line into syslog
        if len(log) > 0:
            first_entry = log[0]
        else:
            sys.exit()

        # Local Variables
        counter = 0
        self.second = 0
        self.minute = 0
        self.hour = 0
        self.day = 1
        self.month = str(first_entry.month)
        self.year = first_entry.year
        self.unit = "month"
        self.duration = 12

        start_date = datetime.datetime(int(self.year),int(self.month),int(self.day),int(self.hour),int(self.minute),int(self.second))
        start_key = start_date.year+start_date.month

        # Zero out each entry, this will fill in blanks which
        # may be in the log, especially sparse logs.
        for i in range(0, self.duration):

            # Calculate the current date, the last one will be the end date
            end_date = start_date + datetime.timedelta(days=i*365/12 + 1)
            end_key = str(end_date.year)+str("%.2d" % (end_date.month))
            self.zero(end_key)
            logging.debug("End Date: " + str(end_date))
            logging.debug("End Key: " + end_key)

            # Check for middle date and save
            if i == (self.duration/2):
                middle_date = end_date

        # Save final values
        self.start_date = start_date
        self.middle_date = middle_date
        self.end_date = end_date

        # Create a dictionary with an entry for each line. Increment
        # the value for each time the word is found. Merge lines by
        # Removing numbers and replacing them with a single '#'
        for entry in log:

            # Create key rooted in time
            key = entry.year+entry.month

            # Check to make sure key is found in the list built above
            if key in list(self.keys()):
                self.increment(key)

        self.build_calculations()


class YearsGraph(GraphHash):
    """10 year graph subtype"""

    def __init__(self, log):

        # Call parent init
        UserDict.__init__(self)

        # Turn first line into syslog
        if len(log) > 0:
            first_entry = log[0]
        else:
            sys.exit()

        # Local Variables
        counter = 0
        self.second = 0
        self.minute = 0
        self.hour = 0
        self.day = 1
        self.month = 1
        self.year = first_entry.year
        self.unit = "year"
        self.duration = 10

        start_date = datetime.datetime(int(self.year),int(self.month),int(self.day),int(self.hour),int(self.minute),int(self.second))
        start_key = start_date.year

        # Zero out each entry, this will fill in blanks which
        # may be in the log, especially sparse logs.
        for i in range(0, self.duration):

            # Calculate the current date, the last one will be the end date
            end_date = start_date + datetime.timedelta(days=i*365)
            end_key = str(end_date.year)
            self.zero(end_key)

            # Check for middle date and save
            if i == (self.duration/2):
                middle_date = end_date

        # Save final values
        self.start_date = start_date
        self.middle_date = middle_date
        self.end_date = end_date

        # Create a dictionary with an entry for each line. Increment
        # the value for each time the word is found. Merge lines by
        # Removing numbers and replacing them with a single '#'
        for entry in log:

            # Create key rooted in time
            key = entry.year

            # Check to make sure key is found in the list built above
            if key in list(self.keys()):
                self.increment(key)

        self.build_calculations()
