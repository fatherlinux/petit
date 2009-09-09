#!/bin/bash

rm -rf deb/chev

# Create directory structure
mkdir -p deb/chev/DEBIAN
mkdir -p deb/chev/usr/local/chev/bin
mkdir -p deb/chev/usr/local/chev/lib
mkdir -p deb/chev/usr/local/chev/etc
mkdir -p deb/chev/usr/local/chev/doc

# Copy in control file
cp deb/control deb/chev/DEBIAN/control

# Now fill with latest data
## Bin
rsync -av --exclude=.svn ../src/bin/ deb/chev/usr/local/chev/bin/

## Docs
cp ../src/AUTHORS deb/chev/usr/local/chev/doc/chev/AUTHORS
cp ../src/COPYING deb/chev/usr/local/chev/doc/chev/COPYING
cp ../src/README deb/chev/usr/local/chev//doc/chev/README

## Lib
rsync -av --exclude=.svn ../src/lib/crunchtools.py deb/chev/usr/local/chev/lib/crunchtools.py

# Build the package
version=`cat deb/control | grep Version | awk '{print $2}'`
dpkg -b deb/chev chev_${version}_i386.deb

# Clean up
rm -rf deb/chev
