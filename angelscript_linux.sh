#! /bin/sh

set -e

mkdir -p build/angelscript/linux-debug
mkdir -p build/angelscript/linux-release

cp -r angelscript-2.32.0 angelscriptbuild
cd angelscriptbuild/angelscript/projects/cmake/
cmake -DCMAKE_BUILD_TYPE=Debug .
make -j$(nproc --all)
cd ../../../..

cp angelscriptbuild/angelscript/projects/cmake/libangelscript.a build/angelscript/linux-debug

rm -r angelscriptbuild

cp -r angelscript-2.32.0 angelscriptbuild
cd angelscriptbuild/angelscript/projects/cmake/
cmake -DCMAKE_BUILD_TYPE=Release .
make -j$(nproc --all)
cd ../../../..

cp angelscriptbuild/angelscript/projects/cmake/libangelscript.a build/angelscript/linux-release

rm -r angelscriptbuild

cp angelscript-2.32.0/angelscript/include/angelscript.h build/angelscript
