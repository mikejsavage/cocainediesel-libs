#! /bin/sh

set -x
. ./common_linux.sh

flags="-DTRACY_STATIC=ON"
standard_cmake tracy tracy-0.11.1 libTracyClient.a "$flags"

rm -r tracybuild
