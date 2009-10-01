#/bin/bash

# Variables
home_location="/srv/operations/tools"
yum_location="/srv/yum/redhat/RHEL/5/eyemg/"
remote_location="root@mobius:/usr/web/opensource.eyemg.com/docroot/files/petit/"


# Get version from admin
echo -n "What version of petit will you be distributing (X.X.X)? "
read version

# Make sure directory is clean for distribution
cd petit
make clean
cd ..
tar cvvfz petit-${version}.tgz petit/
scp petit-${version}.tgz $remote_location

# Now create RPM and distribute
cd petit
make rpm
scp petit-[0-9].[0-9].[0-9]-[0-9].i386.rpm $remote_location
cp petit-[0-9].[0-9].[0-9]-[0-9].i386.rpm $yum_location/
cd $yum_location/
createrepo .

# Cleanup
cd $home_location
rm -f petit-${version}.tgz
cd petit
make clean
