#!/bin/sh
# petit's launcher, installed as /usr/bin/petit by the .rpm and .deb.
#
# petit lives in its own directory, /usr/lib/petit, not in one Python's
# site-packages, so one package runs on whichever Python 3.11 or newer the
# system has: the newest versioned interpreter first, then plain python3.
for py in python3.14 python3.13 python3.12 python3.11 python3; do
    command -v "$py" >/dev/null 2>&1 || continue
    "$py" -c 'import sys; sys.exit(sys.version_info < (3, 11))' 2>/dev/null || continue
    exec "$py" -s -E -c '
import sys
sys.argv[0] = "petit"
sys.path.insert(0, "/usr/lib/petit")
from petit.cli import main
sys.exit(main())
' "$@"
done
echo "petit: needs Python 3.11 or newer (python3.11, python3.12, python3.13 or python3.14)" >&2
exit 1
