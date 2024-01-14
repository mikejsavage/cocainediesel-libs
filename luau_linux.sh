#! /bin/sh

. ./common_linux.sh

standard_cmake luau luau-0.524 "*.a" "" "--target Luau.Ast Luau.Compiler Luau.VM"

cp luau-0.524/Compiler/include/*.h build/luau
cp luau-0.524/VM/include/*.h build/luau

rm -r luaubuild
