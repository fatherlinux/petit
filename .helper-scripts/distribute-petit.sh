#/bin/bash

# Variables
home_location="/srv/operations/tools"
yum_location="/srv/yum/redhat/RHEL/5/eyemg/"
remote_server="root@mobius"
remote_directory="/usr/web/opensource.eyemg.com/docroot/files/petit/"
remote_location="$remote_server:$remote_directory"
deb_server="root@javier.eyemg.com"
deb_location="${deb_server}:/root/software/petit"


# Get version from admin
version=`cat petit/build/rpm/SPECS/petit.spec | grep Version | cut -f2 -d" "`

# Make sure directory is clean for distribution
cd petit
make clean
cd ..
tar cvvfz petit-${version}.tgz petit/
scp petit-${version}.tgz $remote_location
ssh $remote_server "rm $remote_directory/petit-current.tgz"
latest=`ssh $remote_server "ls -trh $remote_directory| grep tgz | tail -n1"`
ssh $remote_server "ln -s $latest $remote_directory/petit-current.tgz"

# Now create RPM and distribute
cd petit
make rpm
scp petit-[0-9].[0-9].[0-9]-[0-9].i386.rpm $remote_location
ssh $remote_server "rm $remote_directory/petit-current.rpm"
latest=`ssh $remote_server "ls -trh $remote_directory| grep rpm | tail -n1"`
ssh $remote_server "ln -s $latest $remote_directory/petit-current.rpm"
cp petit-[0-9].[0-9].[0-9]-[0-9].i386.rpm $yum_location/
cd $yum_location/
createrepo .

# Now create deb and distribute
ssh $deb_server "(cd /root/software/petit; svn update; make clean; make deb)"
petit_pkg=`ssh $deb_server "ls /root/software/petit | grep \.deb | tail -n1" `
echo "Petit package: $petit_pkg"
scp ${deb_location}/${petit_pkg} ${home_location}/petit/${petit_pkg}
scp ${home_location}/petit/${petit_pkg} $remote_location
ssh $remote_server "rm $remote_directory/petit-current.deb"
latest=`ssh $remote_server "ls -trh $remote_directory| grep deb | tail -n1"`
ssh $remote_server "ln -s $latest $remote_directory/petit-current.deb"

# Cleanup
cd $home_location
rm -f petit-${version}.tgz
cd petit
make clean
ssh $deb_server "(cd /root/software/petit; make clean)"

# Update local server
rpm -e petit
yum clean all
yum install petit
