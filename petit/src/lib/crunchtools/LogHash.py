"""Contains SuperHash and all closely related children"""

from UserDict import UserDict
from Filter import Filter
from Log import Log

from LogEntry import SyslogEntry
from LogEntry import RSyslogEntry
from LogEntry import ApacheAccessEntry
from LogEntry import ApacheErrorEntry
from LogEntry import SnortEntry
from LogEntry import RawEntry
from LogEntry import SecureLogEntry

import logging
import choice
import re
import os
import sys

class SuperHash(UserDict):
    """Interface and parent class for all hash/dict based objects. """

    filter = Filter()
    sample = "none"

    def __init__(self, log, filter_filename="__none__"):

        # Call parent init
        UserDict.__init__(self)

        if log[0] != "__none__" and filter_filename != "__none__":
            # Setup log and filter
            self.filter = Filter(filter_filename)
            self.fill(log)

        elif log[0] != "__none__":
            # Setup log without filter
            self.fill(log)
            
        else:
            # Create empty filter
            pass

    def fill(self, log):
        """Interface method which is flled in by subclasses"""
        pass

    def increment(self, key, entry):
        """Adds a new entry to superhash data structures.
        Similar to append for a list"""

        # Check to make sure it exists
        if key not in self:
            self[key] = [0, []]

        # Increment the hashed count
        # Create an array of un-hashed values for sampling later
        self[key][0] += 1
        self[key][1].append(entry)

    def display(self):
        """Displays all entries held in the SuperHash structure"""

        global logging

        # Set static sample threshold
        sample_threshold = 3

        # Debugging
        logging.info("Sample Type: "+self.sample)

        # Print out the dictionary first sorted by the word with
        # the most entries with an alphabetical subsort
        for key in sorted(sorted(self.keys()), \
            cmp=lambda x,y: cmp(self[y][0], self[x][0])):

            # Print all lines as sample
            if self.sample == "all":
                print str(self[key][0]) + ":    " + \
                choice(self[key][1]).log_entry

            elif self.sample == "none":
                print str(self[key][0]) + ":    "+str(key)

            elif self.sample == "threshold":
                # Print sample for small values below/equal to threshold
                if self[key][0] <= sample_threshold:
                    print str(self[key][0]) + ":    " + \
                    self[key][1][0].log_entry
                else:
                    print str(self[key][0]) + ":    " + str(key)
            else:
                print "That type of sampling is not supported:", self.sample
                sys.exit(16)

    def fingerprint(self):
        """
        Remove all fingerprints from a given LogHash and replace with a 
        single string"
        """

        global logging

        # Declarations & Variables
        threshold_coefficient = 0.3
        fingerprints = []
        fingerprint_files = ["__none__"]

        # Load & assign fingerprint files
        prefixes =  [ \
            "/var/lib/petit/fingerprints/", \
            "/usr/local/petit/var/lib/fingerprints/" \
            "/opt/petit/var/lib/fingerprints/"]

        for prefix in prefixes:
            if os.path.exists(prefix) and len(os.listdir(prefix)) >= 1:
                fingerprint_files = os.listdir(prefix)
                break

        if fingerprint_files[0] == "__none__":
            print "Could not locate fingerprint files: ", prefix
            sys.exit()

        for fingerprint_file in fingerprint_files:
            if re.search("fp",fingerprint_file):

                # Create a fullpath name
                filename = prefix+fingerprint_file

                # Build a Log for the fingerprint
                log = Log(filename)

                # Build a SuperHash
                x = SuperHash.manufacture(log, "hash.stopwords")

                x.file_name = fingerprint_file
                fingerprints.append(x)


        # Iterate each fingerprint
        for fingerprint in fingerprints:

            logging.info("Testing Fingerprint:"+fingerprint.file_name)

            # Reset counter for each fingerprint
            count = 0
            threshold = (len(fingerprint) * threshold_coefficient)
            logging.info("Threshold:"+str(threshold))

            # Look for fingerpring
            for key in fingerprint.keys():
                if key in self:
                    count = count+1

                # If Threshold is reached, remove everyline of fingerprint
                # Saves time on searching every entry
                if count > threshold:
                    logging.info("Found Fingerprint:"+fingerprint.file_name)
                    for key in fingerprint.keys():

                        # Key found, plenty to remove
                        if key in self:
                            del self[key]

                    # Force the sample entry to be the same as the key
                    # and based off of the filename of the fingerprint
                    fingerprint[key][1][0].log_entry = fingerprint.file_name
                    self.increment(fingerprint.file_name, fingerprint[key][1][0]) 
                    break

            logging.info("Count: "+str(count))

    def manufacture(log, filter):
        """Factory method which creates new SuperHash of correct subtype"""

        # Select the correct build method
        if log.contains(SyslogEntry):
            LogHash = SyslogHash
        elif log.contains(RSyslogEntry):
            LogHash = SyslogHash
        elif log.contains(ApacheAccessEntry):
            LogHash = ApacheLogHash
        elif log.contains(ApacheErrorEntry):
            LogHash = ApacheLogHash
        elif log.contains(SnortEntry):
            LogHash = SnortLogHash
        elif log.contains(RawEntry):
            LogHash = RawLogHash
        elif log.contains(SecureLogEntry):
            LogHash = SecureLogHash
        else:
            print "Could not determine what type of objects are contained in generic Log"""
            sys.exit(15)

        # Build and return the correct subclass instance based on log file type
        return LogHash(log, filter)

    manufacture = staticmethod(manufacture)


class SyslogHash(SuperHash):
    """Overrides the fill method specifically for LogHashes built from Syslog files"""
    
    def fill(self, log):
        # Create a dictionary with an entry for each line. Increment
        # the value for each time the word is found. Merge lines by
        # Removing numbers and replacing them with a single '#'
        for entry in log:

            # Scrub sections of SyslogEntry which will be used to key the hash
            key = self.filter.scrub(entry.daemon+" "+entry.log_entry)

            # increment the LogHash with the new key
            self.increment(key, entry)

        # Finally, remove valueless lines
        if "#" in self:    
            del self["#"]

class ApacheLogHash(SuperHash):
    """Overrides the fill method specifically for LogHashes built from Apache logs"""
    
    def fill(self, log):
        # Create a dictionary with an entry for each line. Increment
        # the value for each time the word is found. Merge lines by
        # Removing numbers and replacing them with a single '#'
        for entry in log:

            # Scrub sections of SyslogEntry which will be used to key the hash
            key = self.filter.scrub(entry.log_entry)

            # increment the LogHash with the new key
            self.increment(key, entry)

        # Finally, remove valueless lines
        if "#" in self:    
            del self["#"]


class SnortLogHash(SuperHash):
    """Overrides the fill method specifically for LogHashes built from Snort logs"""
    
    def fill(self, log):
        # Create a dictionary with an entry for each line. Increment
        # the value for each time the word is found. Merge lines by
        # Removing numbers and replacing them with a single '#'
        for entry in log:

            # Scrub sections of SyslogEntry which will be used to key the hash
            key = self.filter.scrub(entry.log_entry)

            # increment the LogHash with the new key
            self.increment(key, entry)

        # Finally, remove valueless lines
        if "#" in self:    
            del self["#"]

class SecureLogHash(SuperHash):
    """Overrides the fill method specifically for LogHashes built from Syslog files"""
    
    def fill(self, log):
        # Create a dictionary with an entry for each line. Increment
        # the value for each time the word is found. Merge lines by
        # Removing numbers and replacing them with a single '#'
        for entry in log:

            # Clean up the log entry better since it is a secure log hash

            ## Session Entries
            entry.log_entry = re.sub("session closed for.*", "session closed for #", entry.log_entry)
            entry.log_entry = re.sub("session opened for.*", "session opened for #", entry.log_entry)

            ## Auth Entries
            entry.log_entry = re.sub("Accepted publickey for.*", "Accepted publickey for #", entry.log_entry)
            entry.log_entry = re.sub("Accepted password for.*", "Accepted password for #", entry.log_entry)
            entry.log_entry = re.sub("Postponed publickey for.*", "Postponed publickey for #", entry.log_entry)
            entry.log_entry = re.sub("input_userauth_request: invalid user.*", "input_userauth_request: invalid user #", entry.log_entry)
            entry.log_entry = re.sub("Invalid user.*", "Invalid user #", entry.log_entry)
            entry.log_entry = re.sub("reverse mapping checking getaddrinfo for.*", "reverse mapping checking getaddrinfo for #", entry.log_entry)
            entry.log_entry = re.sub("Connection closed by.*", "Connection closed by #", entry.log_entry)
            entry.log_entry = re.sub("Failed password for invalid user.*", "Failed password for invalid user #", entry.log_entry)
            entry.log_entry = re.sub("Failed password for.*from.*", "Failed password for # from #", entry.log_entry)
            entry.log_entry = re.sub("error retrieving information about user.*", "error retrieving information about user #", entry.log_entry)
            entry.log_entry = re.sub("authentication failure.*", "authentication failure #", entry.log_entry)

            ## Misc
            entry.log_entry = re.sub("Received disconnect from.*", "Received disconnect from #", entry.log_entry)
            entry.log_entry = re.sub("Could not reverse map address.*", "Could not reverse map address #", entry.log_entry)
            #entry.log_entry = re.sub("", "", entry.log_entry)

            # Scrub sections of SyslogEntry which will be used to key the hash
            key = self.filter.scrub(entry.daemon+" "+entry.log_entry)

            # increment the LogHash with the new key
            self.increment(key, entry)

        # Finally, remove valueless lines
        if "#" in self:    
            del self["#"]


class RawLogHash(SuperHash):
    """Overrides the fill method specifically for LogHashes built from text files without date/time"""
    
    def fill(self, log):
        # Create a dictionary with an entry for each line. Increment
        # the value for each time the word is found. Merge lines by
        # Removing numbers and replacing them with a single '#'
        for entry in log:

            # Scrub sections of SyslogEntry which will be used to key the hash
            key = self.filter.scrub(entry.log_entry)

            # increment the LogHash with the new key
            self.increment(key, entry)

        # Finally, remove valueless lines
        if "#" in self:    
            del self["#"]


class DaemonHash(SyslogHash):
    """Overides the fill method specifically for a DaemonHashes built from text files with date/time"""

    def fill(self, log):

        # Create a dictionary with an entry for each line. Increment
        # the value for each time the word is found. Merge lines by
        # Removing numbers and replacing them with a single '#'
        for entry in log:

            # Scrub sections of SyslogEntry which will be used to key the hash
            key = self.filter.scrub(entry.daemon)

            # increment the LogHash with the new key
            self.increment(key, entry)

        # Finally, remove valueless lines
        if "#" in self:    
            del self["#"]


class HostHash(SyslogHash):
    """Overides the fill method specifically for a HostHashes built from text files with date/time"""

    def fill(self, log):

        # Create a dictionary with an entry for each line. Increment
        # the value for each time the word is found. Merge lines by
        # Removing numbers and replacing them with a single '#'
        for entry in log:

            # Scrub sections of SyslogEntry which will be used to key the hash
            key = self.filter.scrub(entry.host)

            # increment the LogHash with the new key
            self.increment(key, entry)

        # Finally, remove valueless lines
        if "#" in self:    
            del self["#"]


class WordHash(SuperHash):
    """
    Subclass which creates a dictionary of words which may hold value in a given log file
    Date, time, and other common words are excluded from the count.
    """

    def fill(self, log): 

        # Create a dictionary with an entry for each word. Increment
        # the value for each time the word is found
        for entry in log:
    
            # Base the wordcount on the log_entry payload
            for word in entry.log_entry.split():

                # increment the WordHash with the new key
                self.increment(word, word)


        # Perform bleach at the end because it is more efficient
        for key in self.keys():

            # First scrub any unwanted words
            newkey = self.filter.scrub(key)
            if newkey in self:
                self[newkey] = self[newkey] + self[key]
            else:
                self[newkey] = self[key]

            if newkey != key:
                del self[key]

        # Finally, remove valueless lines
        if "#" in self:    
            del self["#"]
