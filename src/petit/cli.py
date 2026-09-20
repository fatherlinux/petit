#!/usr/bin/env python3
"""Log & text analysis tool for systems administrators


Logtool provides trimming and analysis of ascii based log files
such as syslog.  Different options allow different types of analyis such as
line hashing, hash counting, and word usage counting. These options can be used
to determine WHAT is normal and WHAT to look for, which programs such
as logwatch or swatch cannot do.
"""
###############################################################################
#
# Writen By: Scott McCarty
# Date: 8/2009
# Email: scott.mccarty@gmail.com
#
# Copyright (C) 2009 Scott McCarty
#
# This program is free software: you can redistribute it and/or modify it
# under the terms of the GNU Affero General Public License as published by
# the Free Software Foundation, either version 3 of the License, or (at
# your option) any later version.
#
# This program is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU Affero
# General Public License for more details.
#
# You should have received a copy of the GNU Affero General Public License
# along with this program. If not, see <https://www.gnu.org/licenses/>.
#
###############################################################################

from __future__ import annotations

import argparse
import logging
import signal
import sys
from collections.abc import Callable
from importlib.metadata import PackageNotFoundError
from importlib.metadata import version as pkg_version
from types import FrameType

from petit.CrunchLog import CrunchLog
from petit.errors import PetitError
from petit.LogGraph import (
    DaysGraph,
    HoursGraph,
    MinutesGraph,
    MonthsGraph,
    SecondsGraph,
    YearsGraph,
)
from petit.LogHash import DaemonHash, HostHash, SuperHash, WordHash

AnyGraph = SecondsGraph | MinutesGraph | HoursGraph | DaysGraph | MonthsGraph | YearsGraph

# Process Signals


def sigint_handler(_signum: int, _frame: FrameType | None) -> None:
    sys.exit(0)


## Exit when control-C is pressed
signal.signal(signal.SIGINT, sigint_handler)

## Ignore problems when piping to head
signal.signal(signal.SIGPIPE, signal.SIG_DFL)


def build_parser() -> argparse.ArgumentParser:
    """Adds all options in one concise function"""

    parser = argparse.ArgumentParser(usage="%(prog)s [options] [file]")

    # Handle flags
    parser.add_argument("-v", "--verbose",
                         dest="verbose",
                         action="count",
                         help="Show verbose output")

    parser.add_argument("--sample", dest="sample",
                         action="store_const",
                         const="threshold",
                         default="threshold",
                         help="Show sample output for small numbered entries")

    parser.add_argument("--nosample",
                         dest="sample",
                         action="store_const",
                         const="none",
                         help="Do not sample output for low count entries")

    parser.add_argument("--allsample", dest="sample",
                         action="store_const",
                         const="all",
                         help="Show samples instead of munged text for all entries")

    parser.add_argument("--filter",
                         dest="filter",
                         action="store_true",
                         default=None, help="Use filter files during processing")

    parser.add_argument("--nofilter",
                         dest="filter",
                         action="store_false",
                         help="Do not use filter files during processing")

    parser.add_argument("--wide",
                         dest="wide",
                         action="store_true",
                         default=False,
                         help="Use wider graph characters")

    parser.add_argument("--tick",
                         dest="tick",
                         default="#",
                         help="Change tick character from default")

    parser.add_argument("--fingerprint",
                         dest="fingerprint",
                         action="store_true",
                         default=False,
                         help="Use fingerprinting to remove certain patterns")

    # Handle modes
    parser.add_argument("-V", "--version",
                         dest="mode",
                         action="store_const",
                         const="mode_version",
                         help="Show verbose output")

    parser.add_argument("--hash",
                         dest="mode",
                         action="store_const",
                         const="mode_hash",
                         help="Show hashes of log files with numbers removed")

    parser.add_argument("--wordcount",
                         dest="mode",
                         action="store_const",
                         const="mode_wordcount",
                         help="Show word count for given word")

    parser.add_argument("--daemon",
                         dest="mode",
                         action="store_const",
                         const="mode_daemon",
                         help="show a report of entries from each daemon")

    parser.add_argument("--host",
                         dest="mode",
                         action="store_const",
                         const="mode_host",
                         help="show a report of entries from each host")

    parser.add_argument("--sgraph",
                         dest="mode",
                         action="store_const",
                         const="mode_sgraph",
                         help="show graph of first 60 seconds")

    parser.add_argument("--mgraph",
                         dest="mode",
                         action="store_const",
                         const="mode_mgraph",
                         help="show graph of first 60 minutes")

    parser.add_argument("--hgraph",
                         dest="mode",
                         action="store_const",
                         const="mode_hgraph",
                         help="show graph of first 24 hours")

    parser.add_argument("--dgraph",
                         dest="mode",
                         action="store_const",
                         const="mode_dgraph",
                         help="show graph of first 31 days")

    parser.add_argument("--mograph",
                         dest="mode",
                         action="store_const",
                         const="mode_mograph",
                         help="show graph of first 12 months")

    parser.add_argument("--ygraph",
                         dest="mode",
                         action="store_const",
                         const="mode_ygraph",
                         help="show graph of first 10 years")

    # -V/--version is the default when no mode flag is given at all, exactly
    # as running plain `petit` always has.
    parser.set_defaults(mode="mode_version")

    parser.add_argument("file", nargs="?", default=None)

    return parser


def mode_version(_args: argparse.Namespace, _filename: str) -> None:
    """Version information"""
    try:
        current_version = pkg_version("petit-log")
    except PackageNotFoundError:
        current_version = "unknown"
    print("Version: " + current_version)


def mode_hash(args: argparse.Namespace, filename: str) -> None:
    """Runs in hashing mode"""

    # Get entire log file into ram for speed
    log = CrunchLog(filename)

    # Build the Hash
    if args.filter is None or args.filter is True:
        x = SuperHash.manufacture(log, "hash.stopwords")
    else:
        x = SuperHash.manufacture(log, "__none__")

    if args.fingerprint:
        x.fingerprint()

    # Set sampling type
    x.sample = args.sample

    # Print out the dictionary first sorted by the word with
    # the most entries with an alphabetical subsort
    x.display()


def _run_report_mode(
    hash_cls: type[WordHash | DaemonHash | HostHash], stopwords: str, filename: str,
) -> None:
    """Build one of the fixed-stopword-file reports and display it.

    --wordcount, --daemon and --host differ only in which SuperHash subclass
    and packaged stopword file they use.
    """
    log = CrunchLog(filename)
    x = hash_cls(log, stopwords)
    x.display()


def mode_wordcount(_args: argparse.Namespace, filename: str) -> None:
    """Runs wordcount mode"""
    _run_report_mode(WordHash, "words.stopwords", filename)


def mode_daemon(_args: argparse.Namespace, filename: str) -> None:
    """Runs daemon report mode"""
    _run_report_mode(DaemonHash, "daemon.stopwords", filename)


def mode_host(_args: argparse.Namespace, filename: str) -> None:
    """Runs host report mode"""
    _run_report_mode(HostHash, "host.stopwords", filename)


def _run_graph_mode(
    graph_cls: type[AnyGraph],
    args: argparse.Namespace,
    filename: str,
) -> None:
    """Build, configure and display one of the time-window graphs.

    Every --?graph mode differs only in which GraphHash subclass it builds;
    tick/wide/display are identical, so they share this one implementation.
    """
    log = CrunchLog(filename)
    x = graph_cls(log)
    x.tick = args.tick
    x.wide = args.wide
    x.display()


MODE_HANDLERS: dict[str, Callable[[argparse.Namespace, str], None]] = {
    "mode_version": mode_version,
    "mode_hash": mode_hash,
    "mode_wordcount": mode_wordcount,
    "mode_daemon": mode_daemon,
    "mode_host": mode_host,
    "mode_sgraph": lambda args, filename: _run_graph_mode(SecondsGraph, args, filename),
    "mode_mgraph": lambda args, filename: _run_graph_mode(MinutesGraph, args, filename),
    "mode_hgraph": lambda args, filename: _run_graph_mode(HoursGraph, args, filename),
    "mode_dgraph": lambda args, filename: _run_graph_mode(DaysGraph, args, filename),
    "mode_mograph": lambda args, filename: _run_graph_mode(MonthsGraph, args, filename),
    "mode_ygraph": lambda args, filename: _run_graph_mode(YearsGraph, args, filename),
}


def main() -> int:
    """Console-script entry point.

    This is the boundary where a PetitError becomes an exit status. The
    library itself never exits — see petit.errors.
    """
    parser = build_parser()
    args = parser.parse_args()

    filename = args.file if args.file is not None else "__none__"

    # Set Verbosity
    log_level = logging.WARNING
    if args.verbose == 1:
        log_level = logging.INFO
    elif args.verbose == 2:
        log_level = logging.DEBUG

    # Set up basic configuration
    logging.basicConfig(level=log_level)

    try:
        MODE_HANDLERS[args.mode](args, filename)
    except PetitError as exc:
        print("petit: " + str(exc), file=sys.stderr)
        return 1
    except BrokenPipeError:
        # `petit ... | head` is normal usage, not an error.
        return 0
    return 0


if __name__ == "__main__":
    sys.exit(main())
