#!/bin/bash

rm -rf deb/petit

# Create directory structure
mkdir -p deb/petit/DEBIAN
mkdir -p deb/petit/usr/bin
mkdir -p deb/petit/usr/share/doc/petit
mkdir -p deb/petit/var/lib/petit

# Copy in control file
cp deb/control deb/petit/DEBIAN/control

# Now fill with latest data
## Bin
rsync -av --exclude=.svn ../src/bin/ deb/petit/usr/bin/

## Docs
cp ../src/AUTHORS deb/petit/usr/share/doc/petit/AUTHORS
cp ../src/COPYING deb/petit/usr/share/doc/petit/COPYING
cp ../src/README deb/petit/usr/share/doc/petit/README

## Lib
rsync -av --exclude=.svn ../src/lib/ deb/petit/var/lib/petit/

# Build the package
version=`cat deb/control | grep Version | awk '{print $2}'`
dpkg -b deb/petit petit_${version}_i386.deb

# Clean up
rm -rf deb/petit
