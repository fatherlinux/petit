"""
Generic log class which contains a payload of objects which conform to the
LogEntry specification.  Log, which is a List (array) of type LogEntry,  is
relied upon and consumed to build any of the XHash objects such as SuperHash
or GraphHash.
"""

from UserList import UserList

import re
import sys
import logging
from random import choice
import datetime
import time
import types
#import rpdb2; rpdb2.start_embedded_debugger("password")


class Tally():

    matrix = {}
    tally_threshold = 0

    def __init__(self, entry_types, max_sample_lines):

        self.matrix = {}
        self.max_sample_lines = max_sample_lines
        self.tally_threshold = max_sample_lines / 4

        for entry_type in entry_types:
            self.matrix[entry_type] = 0

    def append(self, entry_type):
        self.matrix[entry_type] += 1

    def is_type(self, entry_type):

        # Setup the correct tally logic method
        tally_logic = eval(entry_type).tally_logic

        m = self.matrix[entry_type]
        th = self.tally_threshold
        msl = self.max_sample_lines

        if tally_logic(m, th, msl):
            return True
        else:
            return False


class CrunchLog(UserList):
    """
    Class which extends UserList to provide robust in memory log object
    """

    def __init__(self, filename=""):
        UserList.__init__(self)

        buf = list()

        if filename == "":
            return
        elif filename == "__none__":
            self.f = sys.stdin
        else:
            logging.debug("Opening File: " + filename)
            self.f = open(filename)

        for line in self.f.xreadlines():
            buf.append(line)

        if len(buf) < 1:
            print "No data found"
            sys.exit()

        # Automatically select entry type
        self.Entry = self.select(buf)

        # Save for introspective purpose
        self.payload_type = self.Entry.__name__
        self.file_name = filename
        self.build_date = datetime.datetime.now()

        # Build from entry type
        counter = 0
        for line in buf:
            try:
                self.append(self.Entry(line))
                counter += 1
            except (ValueError, TypeError):
                print "Cannot parse values on line: " + str(counter)
                sys.exit()

        del buf

    def __del__(self):
        self.f.close()

    def select(self, buf):
        """
        Determines which type of entry to use when building CrunchLog by
        by sampling the buffer and using a quarum based on votes for each
        log type
        """

        sample_lines = []
        max_sample_lines = 10
        t = Tally(entry_types, max_sample_lines)

        if len(buf) >= 1:

            # Keep building samples until we get a good set
            while (1):

                # Get X number of samples
                for i in range(0, max_sample_lines):
                    sample_lines.append(choice(buf).split())

                # Build tallies for the collected samples
                for line in sample_lines:
                    for entry_type in entry_types:
                        if eval(entry_type).is_type(line):
                            t.append(entry_type)
                            break

                # Tally logic is determined by driver
                for entry_type in entry_types:
                    if t.is_type(entry_type):
                        logging.info("Determined " + \
                        str(entry_type) + ": " + str(t.matrix[entry_type]))

                        return eval(entry_type)

    def contains(self, obj):
        """Determine what kind of objects are contained in this Log"""
        if len(self) >= 1:
            return isinstance(self[len(self) - 1], obj)
        else:
            return False

    def display(self):
        """Simple display function to show entire log"""
        for entry in self:
            entry.display()

    def subset(self, string):
        """Return Log object with subset of entries based on a filter"""

        newlog = CrunchLog()
        for entry in self:
            if re.search(string, entry.log_entry):
                newlog.append(entry)

        return newlog


class LogEntry:
    """Interface class which specifies generic log format for consumption
    by other classes"""
    year = ""
    month = ""
    day = ""
    hour = ""
    minute = ""
    second = ""
    host = ""
    daemon = ""
    log_entry = ""

    def display(self):
        print "Year: ", self.year, \
              "Month:", self.month, \
              "Day:", self.day, \
              "Hour:", self.hour, \
              "Minute:", self.minute, \
              "Second:", self.second, \
              "Host:", self.host, \
              "Payload", self.log_entry

    def tally_logic(tally, tally_threshold, max_sample_lines):
        if tally > tally_threshold:
            return True
        else:
            return False

    # Declare Static Methods
    tally_logic = staticmethod(tally_logic)

    def set_abnormal(self, value):
        self.year, \
        self.month, \
        self.day, \
        self.hour, \
        self.minute, \
        self.second, \
        self.host, \
        self.daemon = ["1900", "01", "01", "01", "01", "01", "#", "#"]
        self.log_entry = ' '.join(value)

    def set_blank(self):
        self.year, \
        self.month, \
        self.day, \
        self.hour, \
        self.minute, \
        self.second, \
        self.host, \
        self.daemon = ["1900", "01", "01", "01", "01", "01", "#", "#"]
        self.log_entry = "#"


class SyslogEntry(LogEntry):
    """Driver for Syslog. Conforms to LogEntry interface class."""

    def __init__(self, line):

        # Split the line up
        value = line.split()

        # Should be normal log entry
        if len(value) >= 5:

            # Syslog does not store year information so, set to current year
            self.year = str(datetime.date.today().year)
            self.month, self.day, clocktime, self.host, self.daemon = value[:5]
            self.log_entry = ' '.join(value[5:])
            self.hour, self.minute, self.second = clocktime.split(":")

            # Convert month to integer
            self.month = str(time.strptime(self.month, "%b")[1])

            # Normalize integers to standard widths and convert to strings
            self.year = str("%.4d" % (int(self.year)))
            self.month = str("%.2d" % (int(self.month)))
            self.day = str("%.2d" % (int(self.day)))
            self.hour = str("%.2d" % (int(self.hour)))
            self.minute = str("%.2d" % (int(self.minute)))
            self.second = str("%.2d" % (int(self.second)))

        # Abnormal log entry
        elif len(value) >= 1:
            self.year, \
            self.month, \
            self.day, \
            self.hour, \
            self.minute, \
            self.second, \
            self.host, \
            self.daemon = ["1900", "01", "01", "01", "01", "01", "#", "#"]
            self.log_entry = ' '.join(value)

        # Blank line, will be sorted out by scrub
        else:
            self.year, \
            self.month, \
            self.day, \
            self.hour, \
            self.minute, \
            self.second, \
            self.host, \
            self.daemon = ["1900", "01", "01", "01", "01", "01", "#", "#"]
            self.log_entry = "#"

    def is_type(line):
        """Standard function from interface class to determine type"""

        global logging

        if len(line) >= 6:

            # Look for something similar to: "Feb 29 11:53:08" in first
            # three columns
            if re.search("[A-Z][a-z]{2}", line[0]) and \
               re.search("[0-9][0-9]?", line[1]) and \
               re.search("[0-9{2}:[0-9]{2}:[0-9]{2}", line[2]) and not \
               (re.search("^pam_", line[5]) or \
               re.search("^sshd\[", line[4])):
                return True
            else:
                return False
        else:
            return False

    # Declare Static Methods
    is_type = staticmethod(is_type)


class RSyslogEntry(LogEntry):
    """Driver for RSyslog. Conforms to LogEntry interface class."""

    def __init__(self, line):

        # Split the line up
        value = line.split()

        # Should be normal log entry
        if len(value) >= 5:

            # Complete major splits: 2010-06-24T17:56:32.197716-04:00
            date, rtime = value[0].split("T")  # Raw time

            # High precision time with timezone info: 17:56:32.197716-04:00
            hptime, offset = rtime.split("-")

            # Patch for mixed enviornments, milliseconds do not get logged
            # if older Ubuntu 8.04 boxes log to a newer 10.04 server with
            # Rsyslog precision time on.
            if re.search("[0-9]{2}:[0-9]{2}:[0-9]{2}\.[0-9]{6}", hptime):
                time, mseconds = hptime.split(".")  # Miliseconds
            else:
                time = hptime

            # Complete secondary splits
            self.year, self.month, self.day = date.split("-")
            self.hour, self.minute, self.second = time.split(":")
            self.host = value[1]
            self.daemon = value[2]
            self.log_entry = ' '.join(value[3:])

            # Normalize integers to standard widths and convert to strings
            self.year = str("%.4d" % (int(self.year)))
            self.month = str("%.2d" % (int(self.month)))
            self.day = str("%.2d" % (int(self.day)))
            self.hour = str("%.2d" % (int(self.hour)))
            self.minute = str("%.2d" % (int(self.minute)))
            self.second = str("%.2d" % (int(self.second)))

        # Abnormal log entry
        elif len(value) >= 1:
            self.year, \
            self.month, \
            self.day, \
            self.hour, \
            self.minute, \
            self.second, \
            self.host, \
            self.daemon = ["1900", "01", "01", "01", "01", "01", "#", "#"]
            self.log_entry = ' '.join(value)

        # Blank line, will be sorted out by scrub
        else:
            self.year, \
            self.month, \
            self.day, \
            self.hour, \
            self.minute, \
            self.second, \
            self.host, \
            self.daemon = ["1900", "01", "01", "01", "01", "01", "#", "#"]
            self.log_entry = "#"

    def is_type(line):
        """Standard function from interface class to determine type"""

        global logging

        if len(line) >= 1:

            # Look for something similar to: "2011-04-04T"
            if re.search("[0-9]{4}-[0-9]{2}-[0-9]{2}T", line[0]):
                return True
            else:
                return False
        else:
            return False

    # Declare Static Methods
    is_type = staticmethod(is_type)


class ApacheAccessEntry(LogEntry):
    """Driver for Apache Access formatted log files"""

    def __init__(self, line):

        # Split the line up
        value = line.split()

        # Should be normal log entry
        if len(value) >= 12:
            # Grab major chunks from the line
            rhost, \
            ident, \
            ruser, \
            apachedate, \
            junk, \
            junk2, \
            uri, \
            protocol, \
            status, \
            bytes, \
            referer, \
            agent = value[:12]
            self.log_entry = uri

            # Split up something that looks like this: [03/Aug/2009:11:53:08
            datetime = apachedate.split(':')
            date = datetime[0]
            self.hour = datetime[1]
            self.minute = datetime[2]
            self.second = datetime[3]
            dmy = date.split('/')
            self.day = re.sub("\[", "", dmy[0])
            self.month = dmy[1]
            self.year = dmy[2]
            self.host = uri
            daemon = "webserver"

            # Convert month to integer
            self.month = time.strptime(self.month, "%b")[1]

            # Normalize integers to standard widths and convert to strings
            self.year = str("%.4d" % (int(self.year)))
            self.month = str("%.2d" % (int(self.month)))
            self.day = str("%.2d" % (int(self.day)))
            self.hour = str("%.2d" % (int(self.hour)))
            self.minute = str("%.2d" % (int(self.minute)))
            self.second = str("%.2d" % (int(self.second)))

        # Abnormal log entry
        elif len(value) >= 1:
            self.set_abnormal(value)

        # Blank line, will be sorted out by scrub
        else:
            self.set_blank()

    def is_type(line):
        """Standard function from interface class to determine type"""

        global logging

        if len(line) >= 4:

            # Look for: "03/Aug/2009:11:53:08" in forth column
            r = "[0-9]{2}/[a-zA-Z]{3}/[0-9]{4}:[0-9{2}:[0-9]{2}:[0-9]{2}"
            if re.search(r, line[3]):
                return True
            else:
                return False
        else:
            return False

    # Declare Static Methods
    is_type = staticmethod(is_type)


class ApacheErrorEntry(LogEntry):
    """Driver for Apache Error formatted log files"""

    def __init__(self, line):

        # Split the line up
        value = line.split()

        # Should be normal log entry
        if len(value) >= 5:
            # Grab major chunks from the line
            # Split up something that looks like this:
            # [Sat Feb 27 12:16:10 2010]
            junk, self.month, self.day, clocktime, self.year = value[:5]
            self.log_entry = ' '.join(value[5:])
            self.hour, self.minute, self.second = clocktime.split(":")

            # Convert month to integer
            self.month = time.strptime(self.month, "%b")[1]

            # Clean up the year field
            self.year = re.sub("\]", "", self.year)

            # Normalize integers to standard widths and convert to strings
            self.year = str("%.4d" % (int(self.year)))
            self.month = str("%.2d" % (int(self.month)))
            self.day = str("%.2d" % (int(self.day)))
            self.hour = str("%.2d" % (int(self.hour)))
            self.minute = str("%.2d" % (int(self.minute)))
            self.second = str("%.2d" % (int(self.second)))

        # Abnormal log entry
        elif len(value) >= 1:
            self.set_abnormal(value)

        # Blank line, will be sorted out by scrub
        else:
            self.set_blank()

    def is_type(line):
        """Standard function from interface class to determine type"""

        global logging

        if len(line) >= 5:

            # Look for : [Sat Feb 27 12:16:10 2010]
            if re.search("[[a-zA-Z]{3}", line[0]) and \
               re.search("[0-9]{2}:[0-9]{2}:[0-9]{2}", line[3]) and \
               re.search("[0-9]{4}", line[4]):
                return True
            else:
                return False
        else:
            return False

    # Declare Static Methods
    is_type = staticmethod(is_type)


class SecureLogEntry(LogEntry):
    """Driver for Syslog. Conforms to LogEntry interface class."""

    def __init__(self, line):

        # Split the line up
        value = line.split()

        # Should be normal log entry
        if len(value) >= 5:
            # Syslog does not store year information so, set to current year
            self.year = str(datetime.date.today().year)
            self.month, self.day, clocktime, self.host, self.daemon = value[:5]
            self.log_entry = ' '.join(value[5:])
            self.hour, self.minute, self.second = clocktime.split(":")

            # Convert month to integer
            self.month = str(time.strptime(self.month, "%b")[1])

            # Normalize integers to standard widths
            self.year = str("%.4d" % (int(self.year)))
            self.month = str("%.2d" % (int(self.month)))
            self.day = str("%.2d" % (int(self.day)))
            self.hour = str("%.2d" % (int(self.hour)))
            self.minute = str("%.2d" % (int(self.minute)))
            self.second = str("%.2d" % (int(self.second)))

        # Abnormal log entry
        elif len(value) >= 1:
            self.set_abnormal(value)

        # Blank line, will be sorted out by scrub
        else:
            self.set_blank()

    def is_type(line):
        """Standard function from interface class to determine type"""

        global logging

        if len(line) >= 6:

            # Look for something similar to: "29 11:53:08" in third column
            if re.search("[0-9][0-9]?", line[1]) \
            and re.search("[0-9{2}:[0-9]{2}:[0-9]{2}", line[2]) \
            and (re.search("^pam_", line[5]) \
            or re.search("^sshd\[", line[4])):
                return True
            else:
                return False
        else:
            return False

    # Declare Static Methods
    is_type = staticmethod(is_type)

    def tally_logic(tally, tally_threshold, max_sample_lines):
        """Override tally logic for secure logs"""

        if tally >= max_sample_lines:
            return True
        else:
            return False

    # Declare Static Methods
    tally_logic = staticmethod(tally_logic)


class ScriptlogEntry(LogEntry):
    """
    Driver for scriptlog entries. Conforms to LogEntry interface class.
    This allows for a standard syslog entry to have extra fields which
    are used with scriptlogs.
    """

    # Extra variables
    label = "__none__"
    id = "__none__"
    type = "__none__"

    def __init__(self, line):

        # Split the line up
        value = line.split()

        # Should be normal log entry
        if len(value) >= 5:

            # Syslog does not store year information so scriptlog does not
            # So set to current year, set the other fields normally
            self.year = datetime.date.today().year
            self.month, \
            self.day, \
            time, \
            self.host, \
            self.daemon, \
            self.label, \
            self.id, \
            self.type = value[:8]

            self.log_entry = ' '.join(value[8:])
            self.hour, self.minute, self.second = time.split(":")

            # Normalize integers to standard widths and convert to strings
            self.year = str("%.4d" % (int(self.year)))
            self.month = str("%.2d" % (int(self.month)))
            self.day = str("%.2d" % (int(self.day)))
            self.hour = str("%.2d" % (int(self.hour)))
            self.minute = str("%.2d" % (int(self.minute)))
            self.second = str("%.2d" % (int(self.second)))

        # Abnormal log entry
        elif len(value) >= 1:
            self.set_abnormal(value)

        # Blank line, will be sorted out by scrub
        else:
            self.set_blank()

    def is_type(line, label="__none__"):
        """Standard function from interface class to determine type"""

        # Split the line up
        value = str(line).split()

        if len(value) >= 8:

            # Look for special label to determine scriptlog type
            if re.search(re.escape(value[5]), re.escape(label)):
                return True
            else:
                return False
        else:
            return False

    # Declare Static Methods
    is_type = staticmethod(is_type)


class RawEntry(LogEntry):
    """
    Driver for Raw log files. Conforms to LogEntry interface class.
    This also allows raw logs to contain all of the correct fields
    to be worked with just like other entries that actually have time
    values
    """

    def __init__(self, line):

        # Split the line up
        value = line.split()

        # Fake the time/date values, put the entire line in the key
        if len(value) >= 1:
            self.set_abnormal(value)

        # Blank line, will be sorted out by scrub
        else:
            self.set_blank()

    def is_type(line):
        """
        Do minimum checking to ensure there is some data
        """

        if len(line) >= 1:

            # Look for any length of text in the line
            if re.search(".+", str(line)):
                return True
            else:
                return False
        else:
            return False

    # Declare Static Methods
    is_type = staticmethod(is_type)


class SnortEntry(LogEntry):
    """
    Driver for Snort formatted log files. Conforms to LogEntry interface class.
    """

    def __init__(self, line):

        # Split the line up
        value = line.split()

        # Should be normal log entry
        if len(value) >= 2:

            # Snort does not store year information so, set to current year
            self.year = datetime.date.today().year

            # Initial break down
            snortdate = value[:1]
            self.log_entry = ' '.join(value[1:])

            # Looks like "09/29-10:18:46.026172"
            snortdate, junk = snortdate[0].split('.')

            # Looks like "09/29-10:18:46"
            self.month, snortdate = snortdate.split('/')

            # Looks like "29-10:18:46"
            self.day, snortdate = snortdate.split('-')

            # Looks like "10:18:46"
            self.hour, self.minute, self.second = snortdate.split(':')

            # Normalize integers to standard widths and convert to strings
            self.year = str("%.4d" % (int(self.year)))
            self.month = str("%.2d" % (int(self.month)))
            self.day = str("%.2d" % (int(self.day)))
            self.hour = str("%.2d" % (int(self.hour)))
            self.minute = str("%.2d" % (int(self.minute)))
            self.second = str("%.2d" % (int(self.second)))

        # Abnormal value
        elif len(value) >= 1:
            self.set_abnormal(value)

        # Blank line, will be sorted out by scrub
        else:
            self.set_blank()

    def is_type(line):

        global logging

        if len(line) >= 4:

            # Look for : "09/29-10:18:46.026172" in first column
            r = "[0-9]{2}\/[0-9]{2}\-[0-9]{2}\:[0-9]{2}\:[0-9]{2}\.[0-9]{6}"
            if re.search(r, line[0]):
                return True
            else:
                return False
        else:
            return False

    # Declare Static Methods
    is_type = staticmethod(is_type)


# Automatically load a list of drivers for each file type this will be used
# to determine what kind of log it is. Do NOT append the parent LogEntry and
# append RawEntry to the end to preserve last resort logic
ma = sys.modules[__name__].__dict__  # module attributes
entry_types = list()

for i in ma.keys():
    if isinstance(ma[i], types.ClassType):
        if issubclass(ma[i], ma['LogEntry']) and \
                      ma[i].__name__ != "LogEntry" and \
                      ma[i].__name__ != "RawEntry":
            entry_types.append(ma[i].__name__)

entry_types.append("RawEntry")
