#/bin/bash -x

# Variables
home_location="/root/foss/petit"
yum_location="/srv/yum/data/eyemg/eyemg-5-i386"
remote_server="scott@lance.educatedconfusion.com"
remote_directory="/var/www/html/crunchtools.com/wp-content/files/petit"
deb_server="smccarty@patrickregan.org"
deb_location="~/petit/petit"


# Get version from admin
version=`cat petit/build/rpm/SPECS/petit.spec | grep Version | cut -f2 -d" "`

clean() {
	# Clean build
	cd $home_location/petit
	make clean
	cd $home_location
}

make_tar() {
	cd $home_location
	tar cvvfz petit-${version}.tgz petit/ --exclude .svn
	cp petit-${version}.tgz $remote_directory
	rm $remote_directory/petit-current.tgz
	ln -s `ls -trh $remote_directory| grep tgz | tail -n1` $remote_directory/petit-current.tgz

	# Distrbute change log
	cp ${home_location}/petit/CHANGELOG $remote_directory/CHANGELOG
}

make_rpm() {
	cd $home_location/petit
	make rpm
	cp petit-[0-9].[0-9].[0-9]-[0-9].i386.rpm $remote_directory
	rm $remote_directory/petit-current.rpm
	ln -s `ls -trh $remote_directory| grep rpm | tail -n1` $remote_directory/petit-current.rpm
}

make_deb() {
	cd $home_location/petit
	ssh $deb_server "(cd ${deb_location}; hg pull; hg update; make clean; make deb)"
	petit_pkg=`ssh $deb_server "ls ${deb_location} | grep \.deb | tail -n1" `
	echo "Petit package: $petit_pkg"
	scp $deb_server:${deb_location}/${petit_pkg} ${home_location}/petit/${petit_pkg}
	cp ${home_location}/petit/${petit_pkg} $remote_directory
	rm $remote_directory/petit-current.deb
	ln -s `ls -trh $remote_directory| grep deb | tail -n1` $remote_directory/petit-current.deb
}

clean() {
	cd $home_location
	rm -f petit-${version}.tgz
	cd petit
	make clean
	ssh $deb_server "(cd $deb_location; make clean)"

	# Show new files
	ls -ltrh /var/www/html/crunchtools.com/wp-content/files/petit/ | tail
}

make_tar
make_rpm
make_deb
clean
