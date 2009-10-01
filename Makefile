
default: FORCE
	@echo "Specify what to build: petit chev"
	@echo "	Usage: make petit"

FORCE:

clean : FORCE
	(cd petit;make clean)

test : FORCE
	(cd petit/test/; time ./test.sh)

petit : FORCE
	.helper-scripts/distribute-petit.sh

deb : petit*.deb

petit*.deb : ./src/bin/* ./src/lib/* ./src/lib/filters/* ./src/lib/fingerprints/* ./src/lib/fingerprint_library/*
	./build/scripts/deb.sh
