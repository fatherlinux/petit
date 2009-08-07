
default: FORCE
	@echo "Specify package to build: rpm, deb"
	@echo "	Usage: make rpm"

FORCE:

clean :
	rm -f petit*.i386.rpm

rpm : petit*.rpm

petit*.rpm : ../src/bin/petit
	scripts/rpm.sh
	mv rpm/RPMS/i386/petit-1-e1.i386.rpm ./
