#! /bin/sh

set -e

mkdir -p build/zstd/linux-debug
mkdir -p build/zstd/linux-release

cp -r zstd-1.4.9 zstdbuild
cd zstdbuild/lib
make -j$(nproc --all) lib-release
cd ../..

cp zstdbuild/lib/libzstd.a build/zstd/linux-debug
cp zstdbuild/lib/libzstd.a build/zstd/linux-release

rm -r zstdbuild

cp zstd-1.4.9/lib/zstd.h build/zstd
