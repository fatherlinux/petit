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
rsync -av --exclude=.svn ../src/bin/ deb/usr/bin/

## Docs
cp ../src/AUTHORS deb/usr/share/doc/petit/AUTHORS
cp ../src/COPYING deb/usr/share/doc/petit/COPYING
cp ../src/README deb/usr/share/doc/petit/README

## Lib
rsync -av --exclude=.svn ../src/lib/ deb/var/lib/petit/

# Build the package
dpkg -b deb/petit petit_0.8.1_i386.deb

# Clean up
rm -rf deb/petit
