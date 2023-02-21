#! /bin/sh

set -e

mkdir -p build/zstd/macos-debug
mkdir -p build/zstd/macos-release

export MACOSX_DEPLOYMENT_TARGET="10.13"
flags="-DZSTD_BUILD_PROGRAMS=OFF -DZSTD_BUILD_SHARED=OFF"

cp -r zstd-1.5.0 zstdbuild
cd zstdbuild

cmake -Bbuild -GXcode -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" $flags build/cmake
cmake --build build --config Release

cd ..

cp zstdbuild/build/lib/Release/libzstd.a build/zstd/macos-debug
cp zstdbuild/build/lib/Release/libzstd.a build/zstd/macos-release

rm -r zstdbuild
