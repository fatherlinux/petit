#!/bin/bash

# Create tar file
tar cfz rpm/SOURCES/petit.tar.gz --exclude=.svn ../src/ &>/dev/null

# Go create the source distribution, then come back
# Experimental work to use distutils to create RPM
#cd ../src
#python setup.py bdist --dist-dir ../build/rpm/SOURCES/
#cd ../build

# Build custom environment
OLDHOME=$HOME
export HOME=`pwd`/rpm
echo "Changeing home to $HOME"
cd ~/

# Create new rpmmacros file
echo "%_topdir $HOME" > .rpmmacros

# Build it
rpmbuild -ba SPECS/petit.spec

# Move newly created files into current directory
cd $HOME
mv ../rpm/RPMS/i386/petit*.i386.rpm ../
mv ../rpm/SRPMS/petit*.src.rpm ../

# Restore environment
export HOME=$OLDHOME
rm .rpmmacros
