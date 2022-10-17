#!/usr/bin/env python

import glob
import os

from distutils.core import setup

setup(
    name="petit",
    version="0.8.5",
    description="Log analysis tool for syslog, apache and raw log files",
    long_description="Log analysis tool which is useful to systems administrators & systems analysts. This tool interacts with syslog and apache logs to clarify what is happening in logs.",
    author="Scott McCarty",
    author_email="smccarty@eyemg.com",
    url="http://opensource.eyemg.com/index.php/Petit",
    scripts=["bin/petit"],
    py_modules=["lib.crunchtools"],
    data_files=[
        (
            "/var/lib/petit/fingerprints",
            glob.glob(os.path.join("lib", "fingerprints", "*.fp")),
        ),
        (
            "petit/lib/fingerprint_library",
            glob.glob(os.path.join("lib", "fingerprint_library", "*.fp")),
        ),
        (
            "/var/lib/petit/filters",
            glob.glob(os.path.join("lib", "filters", "*.stopwords")),
        ),
    ],
)
