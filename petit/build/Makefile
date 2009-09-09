
default: FORCE
	@echo "Specify package to build: rpm, deb"
	@echo "	Usage: make rpm"

FORCE:

clean :
	rm -f chev*.i386.rpm
	rm -f chev*.src.rpm
	rm -f chev*.deb

rpm : petit*.rpm

petit*.rpm : ../src/bin/* ../src/lib/* ../src/etc/*
	scripts/rpm.sh

deb : petit*.deb

petit*.deb : ../src/bin/* ../src/lib/* ../src/etc/*
	scripts/deb.sh
