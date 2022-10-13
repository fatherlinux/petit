#!/bin/bash

# Create tar file
tar cf build/rpm/SOURCES/petit.tar --exclude=.svn src/ &>/dev/null
tar rf build/rpm/SOURCES/petit.tar AUTHORS &>/dev/null
tar rf build/rpm/SOURCES/petit.tar COPYING &>/dev/null
tar rf build/rpm/SOURCES/petit.tar README &>/dev/null

# Go create the source distribution, then come back
# Experimental work to use distutils to create RPM
#cd ../src
#python setup.py bdist --dist-dir ../build/rpm/SOURCES/
#cd ../build

# Build custom environment
OLDHOME=$HOME
export HOME=`pwd`/build/rpm
echo "Changeing home to $HOME"
cd ~/

# Create new rpmmacros file
echo "%_topdir $HOME" > .rpmmacros

# Build it
rpmbuild -ba SPECS/petit.spec

# Move newly created files into current directory
cd $HOME
mv ../rpm/RPMS/i386/petit*.i386.rpm ../../
mv ../rpm/SRPMS/petit*.src.rpm ../../

# Restore environment
export HOME=$OLDHOME
rm .rpmmacros
