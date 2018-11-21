#! /bin/sh

set -e

mkdir -p build/zlib/linux-debug
mkdir -p build/zlib/linux-release

cp -r zlib-1.2.11 zlibbuild

cd zlibbuild
cmake -DCMAKE_BUILD_TYPE=Debug .
make -j$(nproc --all)
cd ..

cp zlibbuild/libzlibstaticd.a build/zlib/linux-debug/libzlib.a

rm -r zlibbuild

cp -r zlib-1.2.11 zlibbuild

cd zlibbuild
cmake -DCMAKE_BUILD_TYPE=Release .
make -j$(nproc --all)
cd ..

cp zlibbuild/libzlibstatic.a build/zlib/linux-debug/libzlib.a

rm -r zlibbuild
