#!/bin/bash

rm -rf deb/petit

# Create directory structure
mkdir -p deb/petit/DEBIAN
mkdir -p deb/petit/usr/bin
mkdir -p deb/petit/usr/share/petit
mkdir -p deb/petit/usr/share/doc/petit
mkdir -p deb/petit/var/lib/petit

# Copy in control file
cp deb/control deb/petit/DEBIAN/control

# Now fill with latest data
## Bin
rsync -av --exclude=.svn ../src/bin/ deb/petit/usr/bin/

## Docs
cp AUTHORS deb/petit/usr/share/doc/petit/AUTHORS
cp COPYING deb/petit/usr/share/doc/petit/COPYING
cp README deb/petit/usr/share/doc/petit/README

## Lib
rsync -av --exclude=.svn ../src/lib/fingerprint_library/ deb/petit/var/lib/petit/fingerprint_library/
rsync -av --exclude=.svn ../src/lib/fingerprints/ deb/petit/var/lib/petit/fingerprints/
rsync -av --exclude=.svn ../src/lib/filters/ deb/petit/var/lib/petit/filters/
rsync -av --exclude=.svn ../src/lib/crunchtools.py deb/petit/usr/share/petit/crunchtools.py

# Build the package
version=`cat deb/control | grep Version | awk '{print $2}'`
dpkg -b deb/petit petit_${version}_i386.deb

# Clean up
rm -rf deb/petit
