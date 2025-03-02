#! /bin/sh

. ./common_macos.sh

EXTRA_BUILD_ARGS="--target Luau.Ast Luau.Compiler Luau.VM"
standard_cmake luau luau-0.524 "*.a"
