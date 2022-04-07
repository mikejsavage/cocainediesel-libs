#! /bin/sh

set -e

mkdir -p build/zlib/linux-debug
mkdir -p build/zlib/linux-release

cp -r zlib-1.2.12 zlibbuild

cd zlibbuild
cmake -DCMAKE_BUILD_TYPE=Debug .
make -j$(nproc --all)
cd ..

cp zlibbuild/libz.a build/zlib/linux-debug/libzlib.a

rm -r zlibbuild

cp -r zlib-1.2.12 zlibbuild

cd zlibbuild
cmake -DCMAKE_BUILD_TYPE=Release .
make -j$(nproc --all)
cd ..

cp zlibbuild/libz.a build/zlib/linux-release/libzlib.a

rm -r zlibbuild

cp zlib-1.2.12/zlib.h build/zlib
cp zlib-1.2.12/zconf.h build/zlib
