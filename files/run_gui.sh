#!/usr/bin/env bash
#
# Run the GRASS GUI, after activating the virtualenv

# the 'dirname readlink' line finds the directory where this script is located.
# https://stackoverflow.com/questions/59895/getting-the-source-directory-of-a-bash-script-from-within
GRASS_SRC="$(dirname $(readlink -f $0))"

source "${GRASS_SRC}"/venv/bin/activate
exec "${GRASS_SRC}"/bin.x86_64-pc-linux-gnu/grass77 "$@"
