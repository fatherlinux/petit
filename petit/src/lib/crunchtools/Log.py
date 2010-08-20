"""
Generic log class which contains a payload of objects which conform to the LogEntry specification.
Log, which is an array of type LogEntry,  is relied upon and consumed to build a SuperHash or GraphHash.
"""

from UserList import UserList
import re
import sys
import logging
from random import choice
from SecureLogEntry import SecureLogEntry
from SyslogEntry import SyslogEntry
from RSyslogEntry import RSyslogEntry
from ApacheEntry import ApacheAccessEntry
from ApacheEntry import ApacheErrorEntry
from SnortEntry import SnortEntry
from RawEntry import RawEntry


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
                while max_sample_lines >= 0:
                    sample_lines.append(choice(buf).split())
                    max_sample_lines -= 1

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
                if tally['SecureLogEntry'] == max_sample_lines:
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
