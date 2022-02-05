#! /bin/sh

set -e

mkdir -p build/luau/linux-debug
mkdir -p build/luau/linux-release

cp -r luau-0.512 luaubuild
cd luaubuild

make -j$(nproc --all) build/debug/libluauast.a build/debug/libluaucompiler.a build/debug/libluauvm.a
make -j$(nproc --all) config=release build/release/libluauast.a build/release/libluaucompiler.a build/release/libluauvm.a

cd ..

cp luaubuild/build/debug/*.a build/luau/linux-debug
cp luaubuild/build/release/*.a build/luau/linux-release

rm -r luaubuild

cp luau-0.512/Compiler/include/*.h build/luau
cp luau-0.512/VM/include/*.h build/luau
