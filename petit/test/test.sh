#!/bin/bash
# 
# Written By: Scott McCarty <smccarty@eyemg.com>
# Date: 9/2009
# Description: Simple integration test to make sure things work rudamentarily well

# First test with no input, should print version
if ! petit
then
	echo " Failed: Default with no input"
	exit 1
else
	echo " Passed: Default with no input"
fi

# Routine Tests
functions="hash wordcount host daemon sgraph mgraph hgraph dgraph mograph ygraph"

for function in $functions
do

	for test in `ls data/*.log`
	do
		# Get the right name for the test
		test=`basename $test | cut -f1 -d"."`

		# Update files?
		if [ "$1" == "update" ]
		then
			echo "Updating: petit --$function $test.log: "
			petit --${function} data/${test}.log > output/${test}-${function}.output
		fi

		# Run test
		echo -n "Testing: petit --$function $test.log: "
		petit --${function} data/${test}.log > ${test}-${function}.tmp

		if ! diff output/${test}-${function}.output ${test}-${function}.tmp
		then
			echo " Failed"
			#rm ${test}-${function}.tmp
			exit 1
		else
			rm ${test}-${function}.tmp
			echo " Passed"
		fi

	done
done

# Special hashing tests

options="fingerprint nosample nofilter"
function="hash"

for option in $options
do
	for test in `ls data/*.log`
	do
		# Get the right name for the test
		test=`basename $test | cut -f1 -d"."`

		# Run test
		# Update files?
		if [ "$1" == "update" ]
		then
			echo "Updating: petit --$function --${option} $test.log: "
			petit --${function} --${option} data/${test}.log > output/${test}-${function}-${option}.output
		fi

		# Run Test
		echo -n "Testing: petit --$function --${option} $test.log: "
		petit --${function} --${option} data/${test}.log > ${test}-${function}-${option}.tmp

		if ! diff output/${test}-${function}-${option}.output ${test}-${function}-${option}.tmp
		then
			echo " Failed"
			#rm ${test}-${function}-${option}.tmp
			exit 1
		else
			rm ${test}-${function}-${option}.tmp
			echo " Passed"
		fi
	done
done
