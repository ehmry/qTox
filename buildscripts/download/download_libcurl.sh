#!/bin/bash

#    Copyright © 2022 by Zoff
#
#    This program is libre software: you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation, either version 3 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.

set -euo pipefail

LIBCURL_VERSION="7.80.0"
LIBCURL_HASH="dab997c9b08cb4a636a03f2f7f985eaba33279c1c52692430018fae4a4878dc7"
LIBCURL_FILENAME="curl-7.80.0.tar.gz"

source "$(dirname "$(realpath "$0")")/common.sh"

download_verify_extract_tarball \
    "https://github.com/curl/curl/releases/download/curl-7_80_0/curl-7.80.0.tar.gz" \
    ${LIBCURL_HASH}
