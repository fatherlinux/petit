
default: FORCE
	@echo "Specify what to build: rpm, deb, test, update-test, install-rpm"
	@echo "	Usage: make rpm"

FORCE:

clean : FORCE
	rm -f petit*.i386.rpm
	rm -f petit*.src.rpm
	rm -f petit*.deb
	rm -f build/rpm/SOURCES/*
	rm -f build/rpm/BUILD/*

test : FORCE
	(cd test/; time ./test.sh)

update-test : FORCE
	(cd test/; ./test.sh update)

rpm : petit*.rpm

petit*.rpm : ./src/bin/* ./src/lib/* ./src/lib/filters/* ./src/lib/fingerprints/* ./src/lib/fingerprint_library/*
	./build/scripts/rpm.sh

deb : petit*.deb

petit*.deb : ./src/bin/* ./src/lib/* ./src/lib/filters/* ./src/lib/fingerprints/* ./src/lib/fingerprint_library/*
	./build/scripts/deb.sh

install : FORCE
	./build/scripts/tar-install.sh

uninstall : FORCE
	./build/scripts/tar-uninstall.sh

install-rpm : rpm
	rpm -e petit
	rpm -ivh petit*.rpm
