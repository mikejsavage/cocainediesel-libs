#! /bin/sh

. ./common_macos.sh

standard_cmake luau luau-0.524 "*.a" "" "--target Luau.Ast Luau.Compiler Luau.VM"
