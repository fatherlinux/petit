"""
Library of utility code useful for systems administrators, analyzing and
manipulating log data.
"""
###############################################################################
#
# Writen By: Scott McCarty
# Date: 8/2009
# Email: scott.mccarty@gmail.com
# Version: 0.8.8
#
# Copyright (C) 2009 Scott McCarty
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 3
# of the License, or (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301
#
###############################################################################

import warnings
import sys
sys.path.append("../")

## Ignore deprication warnings to support a wide range of python versions
warnings.simplefilter('ignore', DeprecationWarning)

