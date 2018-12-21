#! /bin/sh

set -e

mkdir -p build/angelscript/linux-debug
mkdir -p build/angelscript/linux-release

flags="-DCMAKE_CXX_FLAGS=-D_LIBCPP_TYPE_TRAITS"

cp -r angelscript-2.29.2 angelscriptbuild
cd angelscriptbuild/angelscript/projects/cmake/
cmake -DCMAKE_BUILD_TYPE=Debug $flags .
make -j$(nproc --all) Angelscript
cd ../../../..

cp angelscriptbuild/angelscript/lib/libAngelscript.a build/angelscript/linux-debug/libangelscript.a

rm -r angelscriptbuild

cp -r angelscript-2.29.2 angelscriptbuild
cd angelscriptbuild/angelscript/projects/cmake/
cmake -DCMAKE_BUILD_TYPE=Release $flags .
make -j$(nproc --all) Angelscript
cd ../../../..

cp angelscriptbuild/angelscript/lib/libAngelscript.a build/angelscript/linux-release/libangelscript.a

rm -r angelscriptbuild

cp angelscript-2.29.2/angelscript/include/angelscript.h build/angelscript
