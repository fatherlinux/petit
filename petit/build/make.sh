#!/bin/bash

# Create tar file
tar cfz rpm/SOURCES/petit.tar.gz --exclude=.svn ../src/ &>/dev/null

# Build custom environment
OLDHOME=$HOME
export HOME=`pwd`/rpm
echo "Changeing home to $HOME"
cd ~/

# Create new rpmmacros file
echo "%_topdir $HOME" > .rpmmacros

# Build it
rpmbuild -ba SPECS/petit.spec

# Restore environment
export HOME=OLDHOME

