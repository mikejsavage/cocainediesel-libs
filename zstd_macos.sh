#! /bin/sh

set -e

mkdir -p build/zstd/macos-debug
mkdir -p build/zstd/macos-release

# TODO: zstd asm stuff fails to build so don't do this for now
# flags="-DZSTD_BUILD_PROGRAMS=OFF -DZSTD_BUILD_SHARED=OFF -DZSTD_MULTITHREAD_SUPPORT=OFF"
#
# cp -r zstd-1.5.4 zstdbuild
# cd zstdbuild
#
# cmake -Bbuild -GXcode -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" -DCMAKE_OSX_DEPLOYMENT_TARGET=10.13 $flags build/cmake
# cmake --build build --config Release
#
# cd ..
#
# cp zstdbuild/build/lib/Release/libzstd.a build/zstd/macos-debug
# cp zstdbuild/build/lib/Release/libzstd.a build/zstd/macos-release
#
# rm -r zstdbuild

cp -r zstd-1.5.4 zstdbuild
cd zstdbuild/build/single_file_libs

./create_single_file_library.sh
sed -i .bak "s:#define ZSTD_MULTITHREAD:// #DEFINE ZSTD_MULTITHREAD:" zstd.c

flags="-c -O3 -DNDEBUG -mmacosx-version-min=10.13"
clang zstd.c -arch arm64 -o zstd-arm64.o $flags
clang zstd.c -arch x86_64 -o zstd-x64.o $flags

ar r libzstd-arm64.a zstd-arm64.o
ar r libzstd-x64.a zstd-x64.o
lipo libzstd-arm64.a libzstd-x64.a -create -output libzstd.a

cd ../../..

cp zstdbuild/build/single_file_libs/libzstd.a build/zstd/macos-debug
cp zstdbuild/build/single_file_libs/libzstd.a build/zstd/macos-release

rm -r zstdbuild
