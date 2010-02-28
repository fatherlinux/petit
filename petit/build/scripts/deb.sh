#!/bin/bash

rm -rf deb/petit

# Create directory structure
mkdir -p build/deb/petit/DEBIAN
mkdir -p build/deb/petit/usr/bin
mkdir -p build/deb/petit/usr/share/petit
mkdir -p build/deb/petit/usr/share/doc/petit
mkdir -p build/deb/petit/var/lib/petit

# Copy in control file
cp build/deb/control build/deb/petit/DEBIAN/control

# Now fill with latest data
## Bin
rsync -av --exclude=.svn src/bin/ build/deb/petit/usr/bin/

## Docs
cp AUTHORS build/deb/petit/usr/share/doc/petit/AUTHORS
cp COPYING build/deb/petit/usr/share/doc/petit/COPYING
cp README build/deb/petit/usr/share/doc/petit/README

## Lib
rsync -av --exclude=.svn src/lib/fingerprint_library/ build/deb/petit/var/lib/petit/fingerprint_library/
rsync -av --exclude=.svn src/lib/fingerprints/ build/deb/petit/var/lib/petit/fingerprints/
rsync -av --exclude=.svn src/lib/filters/ build/deb/petit/var/lib/petit/filters/
rsync -av --exclude=.svn src/lib/crunchtools.py build/deb/petit/usr/share/petit/crunchtools.py

## Man
rsync -av --exclude=.svn src/man/petit.1.gz build/deb/petit/usr/share/man/man1/petit.1.gz


# Build the package
version=`cat build/deb/control | grep Version | awk '{print $2}'`
dpkg -b build/deb/petit petit_${version}_i386.deb

# Clean up
rm -rf build/deb/petit
