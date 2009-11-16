#!/bin/bash
#
# Written By: Scott McCarty
# Date: 11/2009
# Description: Simple installer script which was built from looking at the RPM
# spec file. This allows petit to be installed on other unix-like operating
# systems such as OSX, Solaris, etc. It has not been test on every platform,
# but it is fairly simple and should work on most.
# 
# You must be root to run this script

# Main scripts & libraries
rm -vf /usr/bin/petit
rm -rvf /usr/share/petit

# Filters, Fingerprints, and Fingerprint Libraries
rm -rvf  /var/lib/petit/

# Licensing & Docs
rm -rvf /usr/share/doc/petit
