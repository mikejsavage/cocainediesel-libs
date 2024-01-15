#! /bin/sh

. ./common_linux.sh

mkdir -p build/zstd/linux-debug
mkdir -p build/zstd/linux-release

zig_version="$(cat zig-cmake/zig_version.txt)"
export CC="$(pwd)/zig-cmake/zig-$zig_version/zig cc"
export CFLAGS="--target=x86_64-linux-musl -O3"
export AR="$(pwd)/zig-cmake/zig-$zig_version/zig ar"

cp -r zstd-1.5.4 zstdbuild
cd zstdbuild
make -j$(nproc --all) lib-release V=1
cd ..

cp zstdbuild/lib/libzstd.a build/zstd/linux-debug
cp zstdbuild/lib/libzstd.a build/zstd/linux-release

rm -r zstdbuild

cp zstd-1.5.4/lib/zstd.h build/zstd
