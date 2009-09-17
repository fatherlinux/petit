
default: FORCE
	@echo "Specify package to build: rpm, deb"
	@echo "	Usage: make rpm"

FORCE:

clean :
	rm -f petit*.i386.rpm
	rm -f petit*.src.rpm
	rm -f petit*.deb
	rm -f build/rpm/SOURCES/petit.tar

rpm : petit*.rpm

petit*.rpm : ./src/bin/* ./src/lib/* ./src/lib/filters/* ./src/lib/fingerprints/* ./src/lib/fingerprint_library/*
	./build/scripts/rpm.sh

deb : petit*.deb

petit*.deb : ./src/bin/* ./src/lib/* ./src/lib/filters/* ./src/lib/fingerprints/* ./src/lib/fingerprint_library/*
	./build/scripts/deb.sh
