"""Defines ScriptLog class"""

from Log import Log
from UserList import UserList
from ScriptlogEntry import ScriptlogEntry
import re
import sys
import os
import logging
import gzip
import sha
import random
import syslog


class ScriptLog(Log):
    """Class which allows special use cases for dealing with Report/Acknowledge"""

    # Variables
    filename = ""
    label = ""
    warn = {}
    crit = {}
    ack = {}

    # Labels
    labels = {}
    labels["warn"] = "__WARN__"
    labels["crit"] = "__CRIT__"
    labels["ack"] = "__ACKN__"
    
    def __init__(self, filename, label="__ScriptLog__", auto_refresh=False):    

        # Initialize variables
        self.filename = filename
        self.label = label
        self.auto_refresh = auto_refresh

        self.fill()

    def open_file(self, filename):
        """Helper function used to open all logs including previously rotated logs"""

        global logging

        # Create new array to hold log data
        buffer = []
        trimfiles = []

        # Check for empty, logfile, or read stdin
        if filename == "":
            return
        elif filename == "__none__":
            f = sys.stdin
        else:

            # Search the directory for all files
            dirname = os.path.dirname(filename)
            basename = os.path.basename(filename)
            files = os.listdir(os.path.dirname(filename))

            # Trim files down to ones that make sense
            for file in files:
                if re.search(basename, file, re.IGNORECASE):
                    
                    # Open the file
                    logging.debug("Opening File: "+dirname+"/"+file)

                    # Check for zip file
                    if re.search("gz", file):
                        f = gzip.open(dirname+"/"+file)
                    else:
                        f = open(dirname+"/"+file)

                    # Read entire contents into array for speed
                    for line in f.readlines():
                        buffer.append(line)

                    # Close file
                    f.close();

        return buffer

    def fill(self):
        """Separate method used to refresh the ScriptLog data structure from file"""

        # Clean up all data structures for each fill
        UserList.__init__(self)
        buffer = ()
        self.warn = {}
        self.crit = {}
        self.ack = {}

        # Create new array to hold log data
        if os.path.exists(self.filename):
            buffer = self.open_file(self.filename)
        else:
            print "File does not exist:", self.filename
            sys.exit(16)

        # Buffer has bow been created and work with file is done
        # Now it is time to determine what kind of objects will be
        # used for construction of self.

        # Finally, build self with the ScriptlogEntries
        for line in buffer:
            
            # Test line to make sure it is a ScriptLog entry, then add
            if ScriptlogEntry.is_type(line, self.label):

                # Setup main list (self)
                self.append(ScriptlogEntry(line.expandtabs()))

                # Setup supporting dictionaries
                # Set Entry
                entry = self[len(self)-1]

                # Parse warning items
                if entry.type == ScriptLog.labels["warn"]:
                    self.warn[entry.id] = True

                # Parse critical items
                if entry.type == ScriptLog.labels["crit"]:
                    self.crit[entry.id] = True

                # If a genuine ack is found, increment
                if entry.type == ScriptLog.labels["ack"]:
                    self.ack[entry.id] = True


    def has_entry(self, line):
        """Check the scriptlog object for an entry which matches the line given"""

        # Always check before adding the entry
        if self.auto_refresh:
            self.fill()

        for entry in self:
            
            # Strip extra spaces out
            line = re.sub("\s+", " ", line)

            # Complete the search
            #if re.search(re.escape(line), entry.log_entry, re.IGNORECASE):
            if line == entry.log_entry:
                return True

        # Default
        return False

    def add_warn(self, line):
        """Added warning entry to syslog"""

        # Generate new SHA has
        h = sha.new(str(random.random())+self.label+" "+ScriptLog.labels["warn"]+" "+line)

        # Write out entry
        syslog.syslog(self.label+" "+h.hexdigest()+" "+ScriptLog.labels["warn"]+" "+line.expandtabs())

        # Refresh the log
        if self.auto_refresh:
            self.fill()

    def add_crit(self, line):
        """Added critical entry to syslog"""

        # Generate new SHA has
        h = sha.new(str(random.random())+self.label+" "+ScriptLog.labels["warn"]+" "+line)

        # Write out entry
        syslog.syslog(self.label+" "+ScriptLog.labels["crit"]+" "+line)

        # Refresh the log
        if self.auto_refresh:
            self.fill()

    def add_ack(self, id): 
        """Added critical entry to syslog"""

        # Write out entry
        syslog.syslog(self.label+" "+id+" "+ScriptLog.labels["ack"])

        # Refresh the log
        if self.auto_refresh:
            self.fill()

    def show_unacknowledged(self):
        """Display function commonly used in derivative works"""

        # Create a list of items
        unack = {}
        RETVAL = 0

        # Reload all data
        self.fill()

        # Build up a list of unacknowledged entries and associated count
        # Then use that list to display all information from the syslog entries

        # Iterate all warn entries and increment
        for k in self.warn:
            if k not in self.ack:
                unack[k] = True
                RETVAL = 1

        for k in self.crit:
            if k not in self.ack:
                unack[k] = True
                RETVAL = 2

        if len(unack) > 0:
            print "Unacknowledged Items:"

            # Iterate full entries so that all information can be printed
            for entry in self:

                if entry.id in unack:
                    print entry.month \
                    +" "+entry.day \
                    +" "+entry.hour+":"+entry.minute+":"+entry.second \
                    +" "+entry.type \
                    +" \""+entry.log_entry+"\""
        else:
            print "OK"

        return RETVAL

    def acknowledge_all(self):
        """Acknowledge all entries which have not otherwise been acknowledged"""

        global logging

        for k in self.warn:
            if k not in self.ack:
                self.add_ack(k)

        for k in self.crit:
            if k not in self.ack:
                self.add_ack(k)

        # Then reload all data
        self.fill()
