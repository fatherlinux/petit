"""Locating the bundled fingerprint and filter data.

The library used to hunt for these under /var/lib/petit and two other absolute
prefixes, which only works when petit is installed by a distro package. Ship
them as package data and resolve them through importlib.resources, so an
install from a wheel, a virtualenv, or a zipapp finds them the same way.

The old prefixes are still searched, last, so an existing system install with
locally added fingerprints keeps working.
"""

from __future__ import annotations

import os
from importlib import resources

LEGACY_PREFIXES = {
    "filters": [
        "/var/lib/petit/filters/",
        "/usr/local/petit/var/lib/filters/",
        "/opt/petit/var/lib/filters/",
    ],
    "fingerprints": [
        "/var/lib/petit/fingerprints/",
        "/usr/local/petit/var/lib/fingerprints/",
        "/opt/petit/var/lib/fingerprints/",
    ],
}


def data_dir(kind: str) -> str | None:
    """Absolute path to the packaged data directory for `kind`, if present."""
    try:
        path = resources.files("petit") / "data" / kind
        if path.is_dir():
            return str(path)
    except (ModuleNotFoundError, AttributeError, TypeError):
        pass
    return None


def search_prefixes(kind: str) -> list[str]:
    """Directories to search for `kind`, packaged data first."""
    prefixes: list[str] = []
    packaged = data_dir(kind)
    if packaged:
        prefixes.append(packaged.rstrip("/") + "/")
    prefixes.extend(LEGACY_PREFIXES.get(kind, []))
    return prefixes


def find(kind: str, filename: str) -> str | None:
    """First existing path for `filename`, or None if nowhere to be found."""
    for prefix in search_prefixes(kind):
        candidate = os.path.join(prefix, filename)
        if os.path.exists(candidate):
            return candidate
    return None
