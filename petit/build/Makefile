
default: FORCE
	@echo "Specify package to build: rpm, deb"
	@echo "	Usage: make rpm"

FORCE:

clean :
	rm -f petit*.i386.rpm
	rm -f petit*.src.rpm

rpm : petit*.rpm

petit*.rpm : ../src/bin/petit
	scripts/rpm.sh
