"""
Generic log class which contains a payload of objects which conform to the 
LogEntry specification.  Log, which is a List (array) of type LogEntry,  is
relied upon and consumed to build any of the XHash object such as SuperHash
or GraphHash.
"""

from UserList import UserList

import re
import sys
import logging
from random import choice
import datetime
import time


class Log(UserList):

    def __init__(self, filename=""):
        UserList.__init__(self)


        # Create new array to hold log data
        buf = self.open_file(filename)

        # Buffer has bow been created and work with file is done
        # Now it is time to determine what kind of objects will be
        # used for construction of self.

        # Get the correct subclass
        Entry = self.select(buf)

        # Finally, build self with the correct subclassed LogEntry constructor type
        for line in buf:
            self.append(Entry(line))

    def open_file(self, filename):
        """Helper function used to open logs"""

        # Create new array to hold log data
        buf = []

        # Check for empty, logfile, or read stdin
        if filename == "":
            return
        elif filename == "__none__":
            f = sys.stdin
        else:
            logging.debug("Opening File: "+filename)   
            f = open(filename)                         

        # Read entire contents into array for speed        
        for line in f.readlines():                         
            buf.append(line)                        

        # Close file                                       
        f.close()

        return buf


    def select(self, buf):
        """Selector which decides what kind of entry to add"""

        # Setup variables
        max_sample_lines = 10
        sample_lines = []
        tally = {'SecureLogEntry': 0, \
                 'SyslogEntry': 0, \
                 'RSyslogEntry': 0, \
                 'ApacheAccessEntry': 0, \
                 'ApacheErrorEntry': 0, \
                 'SnortEntry': 0, \
                 'RawEntry': 0}
        tally_threshold = max_sample_lines/4

        # Check to make sure buffer has data
        if len(buf) >= 1:

            # Keep building samples until we get a good set
            while (1):

                # Get X number of samples
                for i in range(0,max_sample_lines):
                    sample_lines.append(choice(buf).split())

                # Build tallies for the collected samples
                for line in sample_lines:
                    # Test and select correct entry type
                    if SecureLogEntry.is_type(line):
                        tally['SecureLogEntry'] += 1
                    elif SyslogEntry.is_type(line):
                        tally['SyslogEntry'] += 1
                    elif RSyslogEntry.is_type(line):
                        tally['RSyslogEntry'] += 1
                    elif ApacheAccessEntry.is_type(line):
                        tally['ApacheAccessEntry'] += 1
                    elif ApacheErrorEntry.is_type(line):
                        tally['ApacheErrorEntry'] += 1
                    elif SnortEntry.is_type(line):
                        tally['SnortEntry'] += 1
                    else:
                        tally['RawEntry'] += 1

                # Determined which type to return
                if tally['SecureLogEntry'] >= max_sample_lines:
                    logging.info("Determined Secure Log: " + \
                    str(tally['SecureLogEntry']))
                    return SecureLogEntry
                elif tally['SyslogEntry'] > tally_threshold:
                    logging.info("Determined Syslog Log: " + \
                    str(tally['SyslogEntry']))
                    return SyslogEntry
                elif tally['RSyslogEntry'] > tally_threshold:
                    logging.info("Determined RSyslog Log: " + \
                    str(tally['RSyslogEntry']))
                    return RSyslogEntry
                elif tally['ApacheAccessEntry'] > tally_threshold:
                    logging.info("Determined Apache Access Log: " + \
                    str(tally['ApacheAccessEntry']))
                    return ApacheAccessEntry
                elif tally['ApacheErrorEntry'] > tally_threshold:
                    logging.info("Determined Apache Error Log: " + \
                    str(tally['ApacheErrorEntry']))
                    return ApacheErrorEntry
                elif tally['SnortEntry'] > tally_threshold:
                    logging.info("Determined Snort Log: " + \
                    str(tally['SnortEntry']))
                    return SnortEntry
                elif tally['RawEntry'] > tally_threshold:
                    logging.info("Determined Raw Log: " + \
                    str(tally['RawEntry']))
                    return RawEntry


    def contains(self, obj):
        """Determine what kind of objects are contained in this Log"""
        if len(self) >= 1:
            return isinstance(self[len(self)-1], obj)
        else:
            return False


    def display(self):
        """Simple display function to show entire log"""
        for entry in self:
            entry.display()

        
    def subset(self, string):
        """Return a Log object that contains a subset of entries based on a filter"""

        newlog = Log()
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
    """Driver for Syslog formatted files. Conforms to LogEntry interface class."""

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
            self.month = str(time.strptime(self.month,"%b")[1])

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
            self.daemon = ["1900","01","01","01","01","01","#","#"]
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
            self.daemon = ["1900","01","01","01","01","01","#","#"]
            self.log_entry = "#"

    def is_type(line):
        """Standard function from interface class to determine type"""

        global logging

        if len(line) >= 3:

            # Look for something similar to: "29 11:53:08" in third column
            if re.search("[0-9][0-9]?",line[1]) and \
               re.search("[0-9{2}:[0-9]{2}:[0-9]{2}",line[2]):
                return True
            else:
                return False
        else:
            return False

    # Declare Static Methods
    is_type = staticmethod(is_type)


class RSyslogEntry(LogEntry):
    """Driver for RSyslog formatted files. Conforms to LogEntry interface class."""

    def __init__(self, line):

        # Split the line up
        value = line.split()

        # Should be normal log entry
        if len(value) >= 5:

            # Complete major splits: 2010-06-24T17:56:32.197716-04:00
            date, rtime = value[0].split("T") # Raw time

            # High precision time with timezone info: 17:56:32.197716-04:00
            hptime, offset = rtime.split("-")

            # Patch for mixed enviornments, milliseconds do not get logged
            # if older Ubuntu 8.04 boxes log to a newer 10.04 server with
            # Rsyslog precision time on.
            if re.search("[0-9]{2}:[0-9]{2}:[0-9]{2}\.[0-9]{6}", hptime):
                time, mseconds = hptime.split(".") # Miliseconds
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
            self.daemon = ["1900","01","01","01","01","01","#","#"]
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
            self.daemon = ["1900","01","01","01","01","01","#","#"]
            self.log_entry = "#"

    def is_type(line):
        """Standard function from interface class to determine type"""

        global logging

        if len(line) >= 3:

            # Look for something similar to: "29 11:53:08" in third column
            if re.search("[0-9]{4}-[0-9]{2}-[0-9]{2}T",line[0]):
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
            self.month = time.strptime(self.month,"%b")[1]

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

            # Look for something similar to: "03/Aug/2009:11:53:08" in forth column
            if re.search("[0-9]{2}/[a-zA-Z]{3}/[0-9]{4}:[0-9{2}:[0-9]{2}:[0-9]{2}",line[3]):
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
            # Grab major chunks from the line. 
            # Split up something that looks like this: 
            # [Sat Feb 27 12:16:10 2010]
            junk, self.month, self.day, clocktime, self.year = value[:5]
            self.log_entry = ' '.join(value[5:])
            self.hour, self.minute, self.second = clocktime.split(":") 

            # Convert month to integer
            self.month = time.strptime(self.month,"%b")[1]

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

            # Look for something that looks like this: [Sat Feb 27 12:16:10 2010]
            if re.search("[[a-zA-Z]{3}",line[0]) and \
               re.search("[0-9]{2}:[0-9]{2}:[0-9]{2}",line[3]) and \
               re.search("[0-9]{4}",line[4]):
                return True
            else:
                return False
        else:
            return False

    # Declare Static Methods
    is_type = staticmethod(is_type)


class SecureLogEntry(LogEntry):
    """Driver for Syslog formatted files. Conforms to LogEntry interface class."""

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
            self.month = str(time.strptime(self.month,"%b")[1])

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
            if re.search("[0-9][0-9]?",line[1]) \
            and re.search("[0-9{2}:[0-9]{2}:[0-9]{2}",line[2]) \
            and (re.search("^pam_",line[5]) \
            or re.search("^sshd\[",line[4])):
                return True
            else:
                return False
        else:
            return False

    # Declare Static Methods
    is_type = staticmethod(is_type)


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

            # Syslog does not store year information so scriptlog does not, set to current year
            self.year = datetime.date.today().year
            self.month, self.day, time, self.host, self.daemon, self.label, self.id, self.type = value[:8]
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
        value = line.split()

        if len(value) >= 8:

            # Look for special label to determine scriptlog type
            if re.search(value[5] == label):
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
        """Standard function from interface class to determine type"""

        if len(line) >= 1:

            # Look for any length of text in the line
            if re.search(".+",line):
                return True
            else:
                return False
        else:
            return False

    # Declare Static Methods
    is_type = staticmethod(is_type)


class SnortEntry(LogEntry):
    """Driver for Snort formatted log files. Conforms to LogEntry interface class."""

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
        """Standard function from interface class to determine type"""

        global logging

        if len(line) >= 4:

            # Look for something similar to: "09/29-10:18:46.026172" in first column
            if re.search("[0-9]{2}\/[0-9]{2}\-[0-9]{2}\:[0-9]{2}\:[0-9]{2}\.[0-9]{6}",line[0]):
                return True
            else:
                return False
        else:
            return False

    # Declare Static Methods
    is_type = staticmethod(is_type)
