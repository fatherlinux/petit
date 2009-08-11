#!/bin/bash

rm -rf deb/usr deb/var

# Create directory structure
mkdir -p deb/usr/bin
mkdir -p deb/usr/share/doc/petit
mkdir -p deb/var/lib/petit

# Now fill with latest data
## Bin
rsync -av --exclude=.svn ../src/bin/ deb/usr/bin/

## Docs
cp ../src/AUTHORS deb/usr/share/doc/petit/AUTHORS
cp ../src/COPYING deb/usr/share/doc/petit/COPYING
cp ../src/README deb/usr/share/doc/petit/README

## Lib
rsync -av --exclude=.svn ../src/lib/ deb/var/lib/petit/
