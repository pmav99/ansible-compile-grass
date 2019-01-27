#!/usr/bin/env bash
#
# Run the testsuite
#

source venv/bin/activate
cd testsuite/examples
PATH=${PATH}:"$(realpath ../../bin.x86_64-pc-linux-gnu/)"
exec ./test_framework_GRASS_GIS_with_NC.sh test_framework_GRASS_GIS_with_NC.conf
