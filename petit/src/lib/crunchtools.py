#!/usr/bin/env python
"""
Library of utility code useful for systems administrators, analyzing and
manipulating log data.
"""
################################################################################
#
# Writen By: Scott McCarty
# Date: 8/2009
# Email: scott.mccarty@gmail.com
# Version: 0.8.8
#
# Copyright (C) 2009 Scott McCarty
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
#
#################################################################################

import warnings

## Ignore deprication warning, we have to support a wide range of python versions
warnings.simplefilter('ignore', DeprecationWarning)

from optparse import OptionParser
from UserDict import UserDict
from UserString import UserString
from UserList import UserList
from random import choice
from math import ceil
import os
import time
import fileinput
import signal
import re
import sys
import syslog
import gzip
import random
import sha
import logging

class LogEntry:
	"""Interface class which specifies generic log format for consumption by other classes"""

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
		print "Year: ", self.year,"Month:",self.month,"Day:",self.day,"Hour:", self.hour, "Minute:", self.minute, "Second:", self.second, "Host:",self.host,"Payload",self.log_entry


class SyslogEntry(LogEntry):
	"""Driver for Syslog formatted files. Conforms to LogEntry interface class."""

	def __init__(self, line):

		# Split the line up
		value = line.split()

		# Should be normal log entry
		if len(value) >= 5:
			self.month, self.day, time, self.host, self.daemon = value[:5]
			self.log_entry = ' '.join(value[5:])
			self.hour, self.minute, self.second = time.split(":") 

		# Abnormal log entry
		elif len(value) >= 1:
			self.month, self.day, self.hour, self.minute, self.second, self.host, self.daemon = ["#","#","#","#","#","#","#"]
			self.log_entry = ' '.join(value)

		# Blank line, will be sorted out by scrub
		else:
			self.month, self.day, self.hour, self.minute, self.second, self.host, self.daemon = ["#","#","#","#","#","#","#"]
			self.log_entry = "#"

	def is_type(line):
		"""Standard function from interface class to determine type"""

		global logging

		if len(line) >= 3:

			# Look for something similar to: "29 11:53:08" in third column
			if re.search("[0-9]{2}",line[1]) and re.search("[0-9{2}:[0-9]{2}:[0-9]{2}",line[2]):
				logging.info("Found Syslog Entry")
				return True
			else:
				return False
		else:
			return False

	# Declare Static Methods
	is_type = staticmethod(is_type)

class ApacheEntry(LogEntry):
	"""Driver for Apache formatted log files. Conforms to LogEntry interface class."""

	def __init__(self, line):

		# Split the line up
		value = line.split()

		# Should be normal log entry
		if len(value) >= 12:
			# Grab major chunks from the line
			rhost, ident, ruser, apachedate, junk, junk2, uri, protocol, status, bytes, referer, agent = value[:12]
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
			self.host = uri
			daemon = "webserver"

		# Abnormal log entry
		elif len(value) >= 1:
			self.month, self.day, self.hour, self.minute, self.second, self.host, self.daemon = ["#","#","#","#","#","#","#"]
			self.log_entry = ' '.join(value)

		# Blank line, will be sorted out by scrub
		else:
			self.month, self.day, self.hour, self.minute, self.second, self.host, self.daemon = ["#","#","#","#","#","#","#"]
			self.log_entry = "#"

	def is_type(line):
		"""Standard function from interface class to determine type"""

		global logging

		if len(line) >= 4:

			# Look for something similar to: "03/Aug/2009:11:53:08" in forth column
			if re.search("[0-9]{2}/[a-zA-Z]{3}/[0-9]{4}:[0-9{2}:[0-9]{2}:[0-9]{2}",line[3]):
				logging.info("Found Apache Entry")
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

		# Blank line, will be sorted out by scrub
		else:
			self.month, self.day, self.hour, self.minute, self.second, self.host, self.daemon = ["#","#","#","#","#","#","#"]
			self.log_entry = "#"

	def is_type(line):
		"""Standard function from interface class to determine type"""

		global logging

		if len(line) >= 4:

			# Look for something similar to: "09/29-10:18:46.026172" in first column
			if re.search("[0-9]{2}\/[0-9]{2}\-[0-9]{2}\:[0-9]{2}\:[0-9]{2}\.[0-9]{6}",line[0]):
				logging.info("Found Snort Entry")
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
			self.month, self.day, time, self.host, self.daemon, self.label, self.id, self.type = value[:8]
			self.log_entry = ' '.join(value[8:])
			self.hour, self.minute, self.second = time.split(":") 

		# Abnormal log entry
		elif len(value) >= 1:
			self.month, self.day, self.hour, self.minute, self.second, self.host, self.daemon, self.label, self.type = ["#","#","#","#","#","#","#","#","#"]
			self.log_entry = ' '.join(value)

		# Blank line, will be sorted out by scrub
		else:
			self.month, self.day, self.hour, self.minute, self.second, self.host, self.daemon, self.label, self.type = ["#","#","#","#","#","#","#","#","#"]
			self.log_entry = "#"

	def is_type(line, label="__none__"):
		"""Standard function from interface class to determine type"""

		# Split the line up
		value = line.split()

		if len(value) >= 7:

			# Look for warn, crit, or ack in the column 7 to determine scriptlog type
			if re.search(ScriptLog.labels["warn"], value[7]) and value[5] == label:
				return True
			elif re.search(ScriptLog.labels["crit"], value[7]) and value[5] == label:
				return True
			elif re.search(ScriptLog.labels["ack"], value[7]) and value[5] == label:
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
			self.month, self.day, self.hour, self.minute, self.second, self.host, self.daemon = ["#","#","#","#","#","#","#"]
			self.log_entry = ' '.join(value)

		# Blank line, will be sorted out by scrub
		else:
			self.month, self.day, self.hour, self.minute, self.second, self.host, self.daemon = ["#","#","#","#","#","#","#"]
			self.log_entry = "#"

	def is_type(line):
		"""Standard function from interface class to determine type"""

		if len(line) >= 1:

			# Look for any length of text in the line
			if re.search(".+",line):
				logging.info("Found Raw Entry")
				return True
			else:
				return False
		else:
			return False

	# Declare Static Methods
	is_type = staticmethod(is_type)

class Log(UserList):
	"""
	Generic log class which contains a payload of objects which conform to the LogEntry specification.
	Log, which is an array of type LogEntry,  is relied upon and consumed to build a SuperHash or GraphHash.
	"""

	def __init__(self, filename=""):
		UserList.__init__(self)

		# Create new array to hold log data
		buffer = self.open_file(filename)

		# Buffer has bow been created and work with file is done
		# Now it is time to determine what kind of objects will be
		# used for construction of self.

		# Check to make sure buffer has data
		if len(buffer) >= 1:

			# Get a sample of the first entry
			first_entry = buffer[0].split()

			# Get the correct subclass
			Entry = self.select(first_entry)

		# Finally, build self with the correct subclassed LogEntry constructor type
		for line in buffer:
			self.append(Entry(line))

	def open_file(self, filename):
		"""Helper function used to open logs"""

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
			logging.debug("Opening File: "+filename)   
			f = open(filename)                         

		# Read entire contents into array for speed        
		for line in f.readlines():                         
			buffer.append(line)                        

		# Close file                                       
		f.close();

		return buffer

	def select(self, line):
		"""Selector which decides what kind of entry to add"""

		# Test and select correct entry type
		if SyslogEntry.is_type(line):
			return SyslogEntry
		elif ApacheEntry.is_type(line):
			return ApacheEntry
		elif SnortEntry.is_type(line):
			return SnortEntry
		else:
			return RawEntry

	def contains(self, object):
		"""Determine what kind of objects are contained in this Log"""
		if len(self) >= 1:
			return isinstance(self[len(self)-1], object)
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
		import re


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

class Filter:
	"""Filter object used to lad filters into memory once, to save on file operations"""		

	global logging

	file = ""
	prefixes =  [ \
		"/var/lib/petit/filters/", \
		"/usr/local/petit/var/lib/filters/",
		"/opt/petit/var/lib/filters/"]

	stopwords = []

	def __init__(self, file="__none__"):

		global logging

		for prefix in self.prefixes:

			# Set class variable to file & path
			self.file = prefix+file
			self.stopwords = []

			if file == "__none__":
				return
		
			# Open the file and get each stopword or regex		
                        if os.path.exists("%s" % self.file):
				try:
					f = open(self.file)
					for line in f.readlines():

						# Read entire contents into array for speed
						# Save them as compiled regexes for speed
						self.stopwords.append(re.compile(line.rstrip()))
					break

				except IOError:
					print "Could not open Filter file",self.file
					sys.exit(16)

		logging.info("Filter File: "+str(self.file))

	def scrub(self, string):
		"""Used to remove entries and replace them with the scrub character"""

		global logging

		# Check each stopword against each key
		for stopword in self.stopwords:

			# Replace mathces with hash signs
			old_string = string
			string = re.sub(stopword, "#", string)
			logging.debug(" SCRUBBING "+old_string+" OF "+stopword.pattern+" BECOMES "+string)

		return string

	def bleach(self, string):
		"""Determine if a scrub has or should happen"""
		
		if self.scrub(string) == "#":
			return True
		else:
			return False

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
		"""Adds a new entry to superhash data structures. Similar to append for a list"""

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
		for key in sorted(sorted(self.keys()),cmp=lambda x,y: cmp(self[y][0], self[x][0])):

			# Print all lines as sample
			if self.sample == "all":
				print str(self[key][0])+":	"+choice(self[key][1]).log_entry

			elif self.sample == "none":
				print str(self[key][0])+":	"+str(key)

			elif self.sample == "threshold":
				# Print sample for small values below/equal to threshold
				if self[key][0] <= sample_threshold:
					print str(self[key][0])+":	"+self[key][1][0].log_entry
				else:
					print str(self[key][0])+":	"+str(key)
			else:
				print "That type of sampling is not supported:", self.sample
				sys.exit(16)

	def fingerprint(self):
		"""
		Remove all fingerprints from a given LogHash and replace with a single string"
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
		elif log.contains(ApacheEntry):
			LogHash = ApacheLogHash
		elif log.contains(SnortEntry):
			LogHash = SnortLogHash
		elif log.contains(RawEntry):
			LogHash = RawLogHash
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

class GraphHash(UserDict):
	"""Interface class used to control structure & use of all GraphHash subtypes"""

	begin_time = ""
	end_time = ""
	max_value = 0
	min_value = 0
	second = ""
	minute = ""
	hour = ""
	day = ""
	month = ""
	scale = 0.0
	tick = "#"
	width = False

	def __init__(self, log, filter, type):

		# Call parent init
		UserDict.__init__(self)
		self.tick = "#"

	def increment(self, key, entry):
		"""Adds new entry. Similar to append method on list"""

		# Check to make sure it exists
		if key not in self:
			self[key] = [0, []]

		# Increment the hashed count
		# Create an array of un-hashed values for sampling later
		self[key][0] += 1
		self[key][1].append(entry)

	def zero(self, key, entry):
		"""Creates empty entry"""

		# Check to make sure it exists
		if key not in self:
			self[key] = [0, []]
			self[key][1].append(entry)

	def display(self):
		"""Common display function used by all graph subtypes"""

		# Declarations & Variables
		graph_height = 6
		graph_width = len(self)
		scale = float(float(self.max_value)/float(graph_height))

		# Use wide scale or small scale
		if self.wide:
			char_fill = self.tick+" "
			char_blank = "  "
		else:
			char_fill = self.tick
			char_blank = " "
		

		# Create a little space at the top of the screen
		print
		print "Start Time:",self.month, self.day, self.hour+":"+self.minute+":"+self.second,"\t\tMinimum Value:",self.min_value
		print "Duration:",self.duration,"\t\t\tMaximum Value:",self.max_value
		print "Scale:",str(scale)
		print

		# Normalize data
		for key in self.keys():
			if self[key][0] > 0:
				self[key][0] = ceil((float(self[key][0])/float(self.max_value))*graph_height)

		# Print out the dictionary first sorted by the word with
		# the most entries with an alphabetical subsort
		for i in reversed(range(1,graph_height)):
			for key in sorted(self.keys()):
					
				if self[key][0] >= i:
					sys.stdout.write(char_fill)
				else:
					sys.stdout.write(char_blank)
			print

		# Print line of '#' charachters at bottom of screen
		for key in self.keys():
			sys.stdout.write(char_fill)
		print

		# Print marker numbers
		if self.wide:
			transposed_graph_width = (graph_width*2)
			graph_mid = 2
			graph_end = 3
		else:
			transposed_graph_width = graph_width
			graph_mid = 1
			graph_end = 2
			
	 	for i in range(1,transposed_graph_width):
			if i == 1:
				sys.stdout.write("01")
			elif i == (transposed_graph_width/2-graph_mid):
				sys.stdout.write(str(graph_width/2))
			elif i == (transposed_graph_width-graph_end):
				sys.stdout.write(str(graph_width))
			else:
				sys.stdout.write(" ")
		print
			

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

		self.second = "00"
		self.minute = first_entry.minute
		self.hour = first_entry.hour
		self.day = first_entry.day
		self.month = first_entry.month
		self.duration = "60 Seconds"

		# Zero out each entry, this will fill in blanks which
		# may be in the log, especailly sparse logs. Also,
		# adds false sample entry for debugging/printing
		for i in range(0, 60):
			# Convert to two digits
			j =   "%.2d" % (i)
			key = self.month+self.day+self.hour+self.minute+j
			self.zero(key, first_entry)

		# Create a dictionary with an entry for each line. Increment
		# the value for each time the word is found. Merge lines by
		# Removing numbers and replacing them with a single '#'
		for entry in log:

			# Create key rooted in time
			key = self.month+self.day+self.hour+self.minute+entry.second

			# Check to make sure there are not more than 60
			# Also, make sure we are on the right
			# month, day, hour, and minute
			if len(self) <= 60 \
				and entry.month == self.month \
				and entry.day == self.day \
				and entry.hour == self.hour \
				and entry.minute == self.minute:
					self.increment(key, entry)

		# find max value of any key
		for key in self.keys():
			if self[key][0] > self.max_value:
				self.max_value = self[key][0]
		for key in self.keys():
			if self[key][0] < self.max_value:
				self.min_value = self[key][0]

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

		self.second = "00"
		self.minute = "00"
		self.hour = first_entry.hour
		self.day = first_entry.day
		self.month = first_entry.month
		self.duration = "60 Minutes"

		# Zero out each entry, this will fill in blanks which
		# may be in the log, especailly sparse logs. Also,
		# adds false entry for debugging/printing
		for i in range(0, 60):
			# Convert to two digits
			j =   "%.2d" % (i)
			key = self.month+self.day+self.hour+j
			self.zero(key, first_entry)

		# Create a dictionary with an entry for each line. Increment
		# the value for each time the word is found. Merge lines by
		# Removing numbers and replacing them with a single '#'
		for entry in log:

			# Create key rooted in time
			key = self.month+self.day+self.hour+entry.minute

			# Check to make sure there are not more than 60
			# Also, make sure we are on the right
			# month, day, hour, and minute
			if len(self) <= 60 \
				and entry.month == self.month \
				and entry.day == self.day \
				and entry.hour == self.hour:
					self.increment(key, entry)

		# find max value of any key
		for key in self.keys():
			if self[key][0] > self.max_value:
				self.max_value = self[key][0]

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

		self.second = "00"
		self.minute = "00"
		self.hour = "00"
		self.day = first_entry.day
		self.month = first_entry.month
		self.duration = "24 Hours"

		# Zero out each entry, this will fill in blanks which
		# may be in the log, especailly sparse logs. Also,
		# adds false entry for debugging/printing
		for i in range(0, 24):
			# Convert to two digits
			j =   "%.2d" % (i)
			key = self.month+self.day+j
			self.zero(key, first_entry)

		# Create a dictionary with an entry for each line. Increment
		# the value for each time the word is found. Merge lines by
		# Removing numbers and replacing them with a single '#'
		for entry in log:

			# Create key rooted in time
			key = self.month+self.day+entry.hour

			# Check to make sure there are not more than 60
			# Also, make sure we are on the right
			# month, day, hour, and minute
			if len(self) <= 24 \
				and entry.month == self.month \
				and entry.day == self.day:
					self.increment(key, entry)

		# find max value of any key
		for key in self.keys():
			if self[key][0] > self.max_value:
				self.max_value = self[key][0]

