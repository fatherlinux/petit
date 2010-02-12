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
# as published by the Free Software Foundation; either version 3
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
import datetime

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
			self.year, self.month, self.day, self.hour, self.minute, self.second, self.host, self.daemon = ["1900","01","01","01","01","01","#","#"]
			self.log_entry = ' '.join(value)

		# Blank line, will be sorted out by scrub
		else:
			self.year, self.month, self.day, self.hour, self.minute, self.second, self.host, self.daemon = ["1900","01","01","01","01","01","#","#"]
			self.log_entry = "#"

	def is_type(line):
		"""Standard function from interface class to determine type"""

		global logging

		if len(line) >= 3:

			# Look for something similar to: "29 11:53:08" in third column
			if re.search("[0-9][0-9]?",line[1]) and re.search("[0-9{2}:[0-9]{2}:[0-9]{2}",line[2]):
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
			self.year, self.month, self.day, self.hour, self.minute, self.second, self.host, self.daemon = ["1900","01","01","01","01","01","#","#"]
			self.log_entry = ' '.join(value)

		# Blank line, will be sorted out by scrub
		else:
			self.year, self.month, self.day, self.hour, self.minute, self.second, self.host, self.daemon = ["1900","01","01","01","01","01","#","#"]
			self.log_entry = "#"

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


		# Blank line, will be sorted out by scrub
		else:
			self.year,self.month, self.day, self.hour, self.minute, self.second, self.host, self.daemon = ["1900","01","01","01","01","01","#","#"]
			self.log_entry = "#"

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
			self.year, self.month, self.day, self.hour, self.minute, self.second, self.host, self.daemon, self.label, self.type = ["1900","01","01","01","01","01","#","#"]
			self.log_entry = ' '.join(value)

		# Blank line, will be sorted out by scrub
		else:
			self.year, self.month, self.day, self.hour, self.minute, self.second, self.host, self.daemon, self.label, self.type = ["1900","01","01","01","01","01","#","#"]
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
			self.year, self.month, self.day, self.hour, self.minute, self.second, self.host, self.daemon = ["1900","01","01","01","01","01","#","#"]
			self.log_entry = ' '.join(value)

		# Blank line, will be sorted out by scrub
		else:
			self.year, self.month, self.day, self.hour, self.minute, self.second, self.host, self.daemon = ["1900","01","01","01","01","01","#","#"]
			self.log_entry = "#"

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
			self.year, self.month, self.day, self.hour, self.minute, self.second, self.host, self.daemon = ["1900","01","01","01","01","01","#","#"]
			self.log_entry = ' '.join(value)

		# Blank line, will be sorted out by scrub
		else:
			self.year, self.month, self.day, self.hour, self.minute, self.second, self.host, self.daemon = ["1900","01","01","01","01","01","#","#"]
			self.log_entry = "#"

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

		# Get the correct subclass
		Entry = self.select(buffer)

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

	def select(self, buffer):
		"""Selector which decides what kind of entry to add"""

		# Setup variables
		max_sample_lines = 10
		sample_lines = []
		tally = {'SecureLogEntry': 0, 'SyslogEntry': 0, 'ApacheEntry': 0, 'SnortEntry': 0, 'RawEntry': 0}
		tally_threshold = max_sample_lines/4

		# Check to make sure buffer has data
		if len(buffer) >= 1:

			# Keep building samples until we get a good set
			while (1):
			
				# Get X number of samples
				for i in range(0,max_sample_lines):
					sample_lines.append(choice(buffer).split())

				# Build tallies for the collected samples
				for line in sample_lines:
					# Test and select correct entry type
					if SecureLogEntry.is_type(line):
						tally['SecureLogEntry'] += 1
					elif SyslogEntry.is_type(line):
						tally['SyslogEntry'] += 1
					elif ApacheEntry.is_type(line):
						tally['ApacheEntry'] += 1
					elif SnortEntry.is_type(line):
						tally['SnortEntry'] += 1
					else:
						tally['RawEntry'] += 1

				# Determined which type to return
				if tally['SecureLogEntry'] == max_sample_lines:
					logging.info("Determined Secure Log: "+str(tally['SecureLogEntry']))
					return SecureLogEntry
				elif tally['SyslogEntry'] > tally_threshold:
					logging.info("Determined Syslog Log: "+str(tally['SyslogEntry']))
					return SyslogEntry
				elif tally['ApacheEntry'] > tally_threshold:
					logging.info("Determined Apache Log: "+str(tally['ApacheEntry']))
					return ApacheEntry
				elif tally['SnortEntry'] > tally_threshold:
					logging.info("Determined Snort Log: "+str(tally['SnortEntry']))
					return SnortEntry
				elif tally['RawEntry'] > tally_threshold:
					logging.info("Determined Raw Log: "+str(tally['RawEntry']))
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
		for key in self.keys():
			if self[key] > self.max_value:
				self.max_value = self[key]

		# find the minimum value of any key
		self.min_value = self.max_value
		for key in self.keys():
			if self[key] < self.min_value:
				self.min_value = self[key]

	def display(self):
		"""Common display function used by all graph subtypes"""

		# Declarations & Variables
		graph_height = 6
		graph_width = len(self)
		scale = float(float(self.max_value-self.min_value)/float(graph_height))
		graph_position = {}
		graph_value = {}

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
		for key in self.keys():
			if self[key] < graph_min_value:
				graph_min_value = self[key]

		# Check if it should be normalized
		if graph_min_value == 0:

			# Recalculate
			graph_min_value = self.max_value
			for key in self.keys():
				if self[key] < graph_min_value and self[key] != 0:
					graph_min_value = self[key]/2
					print graph_min_value

		# Normalize data
		for key in self.keys():
			if self[key] > 0:

				# Ensure difference between min/max or don't normalize
				if graph_max_value > graph_min_value:
					self[key] = ceil((float(self[key]-graph_min_value)/float(graph_max_value-graph_min_value))*graph_height)

				# Normalize because of difference between min/max
				else:
					self[key] = ceil((float(self[key])/float(graph_max_value))*graph_height)

		# Start Graph Printing
		print

		# Print out the dictionary first sorted by the word with
		# the most entries with an alphabetical subsort
		for i in reversed(range(1,graph_height)):
			for key in sorted(self.keys()):
					
				if self[key] >= i:
					sys.stdout.write(char_fill)
				else:
					sys.stdout.write(char_blank)
			print

		# Print line of '#' charachters at bottom of screen
		for key in self.keys():
			sys.stdout.write(char_fill)
		print

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
		print

		# Create a little space at the top of the screen
		print
		print "Start Time:\t",str(self.start_date),"\t\tMinimum Value:",self.min_value
		print "End Time:\t",str(self.end_date),"\t\tMaximum Value:",self.max_value
		print "Duration:\t",str(self.duration), self.unit+"s","\t\t\tScale:",str(scale)
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
			if key in self.keys():
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
			if key in self.keys():
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
			if key in self.keys():
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
			key = entry.year+entry.month+entry.day

			# Check to make sure key is found in the list built above
			if key in self.keys():
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
			end_date = start_date + datetime.timedelta(days=i*365/12)
			end_key = str(end_date.year)+str("%.2d" % (end_date.month))
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
			key = entry.year+entry.month

			# Check to make sure key is found in the list built above
			if key in self.keys():
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
			if key in self.keys():
				self.increment(key)

		self.build_calculations()
