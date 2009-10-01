#!/bin/bash
# 
# Written By: Scott McCarty <smccarty@eyemg.com>
# Date: 9/2009
# Description: Simple integration test to make sure things work rudamentarily well


# Routine Tests
#functions="hash wordcount host daemon sgraph mgraph hgraph"

#for function in $functions
#do

#	for test in `ls data/*.log`
#	do
		# Get the right name for the test
#		test=`basename $test | cut -f1 -d"."`
#		echo -n "Testing: petit --$function $test.log: "

		# Run test
#		petit --${function} data/${test}.log > ${test}-${function}.tmp

#		if ! diff output/${test}-${function}.output ${test}-${function}.tmp
#		then
#			echo " Failed"
#			rm ${test}-${function}.tmp
#			exit 1
#		else
#			rm ${test}-${function}.tmp
#			echo " Passed"
#		fi
#
#	done
#done

# Special hashing tests

options="fingerprint nosample nofilter"
function="hash"

for option in $options
do
	for test in `ls data/*.log`
	do
		# Get the right name for the test
		test=`basename $test | cut -f1 -d"."`
		echo -n "Testing: petit --$function --${option} $test.log: "

		# Run test
		petit --${function} --${option} data/${test}.log > output/${test}-${function}-${option}.output
		petit --${function} --${option} data/${test}.log > ${test}-${function}-${option}.tmp

		if ! diff output/${test}-${function}-${option}.output ${test}-${function}-${option}.tmp
		then
			echo " Failed"
			rm ${test}-${function}-${option}.tmp
			exit 1
		else
			rm ${test}-${function}-${option}.tmp
			echo " Passed"
		fi
	done
done
