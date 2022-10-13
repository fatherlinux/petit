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
mkdir -p /usr/bin
mkdir -p /usr/share/petit/crunchtools/
cp -vf ./src/bin/petit /usr/bin/petit
cp -vf ./src/lib/crunchtools/* /usr/share/petit/crunchtools/
cp -vf ./src/man/petit.1.gz /usr/share/man/man1/petit.1.gz

# Filters
mkdir -p /var/lib/petit/filters
cp -vf ./src/lib/filters/*.stopwords /var/lib/petit/filters/

# Fingerprints
mkdir -p /var/lib/petit/fingerprints
cp -vf src/lib/fingerprints/* /var/lib/petit/fingerprints/

# Fingerprint Library
mkdir -p /var/lib/petit/fingerprint_library
cp -vf ./src/lib/fingerprint_library/* /var/lib/petit/fingerprint_library/

# Licensing & Docs
mkdir -p /usr/share/doc/petit
cp -vf README /usr/share/doc/petit/README
cp -vf AUTHORS /usr/share/doc/petit/AUTHORS
cp -vf COPYING /usr/share/doc/petit/COPYING

# Completed
echo "Files and libraries installed"
