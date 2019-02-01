#!/usr/bin/env bash
#
# Run the testsuite after activating the venv
#

set -euo pipefail

# the 'dirname readlink' line finds the directory where this script is located.
# https://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within
GRASS_SRC="$(dirname $(readlink -f $0))"
PATH="${PATH}:${GRASS_SRC}/bin.x86_64-pc-linux-gnu/"

source "${GRASS_SRC}"/venv/bin/activate

cd "${GRASS_SRC}"/testsuite/examples
exec ./test_framework_GRASS_GIS_with_NC.sh test_framework_GRASS_GIS_with_NC.conf
