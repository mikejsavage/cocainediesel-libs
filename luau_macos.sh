#! /bin/sh

set -e

mkdir -p build/luau/macos-debug
mkdir -p build/luau/macos-release

cp -r luau-0.524 luaubuild
cd luaubuild

targets="Luau.Ast Luau.Compiler Luau.VM"

cmake -Bbuild -GXcode -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" -DCMAKE_OSX_DEPLOYMENT_TARGET=10.15 .
cmake --build build --target targets --config Debug
cmake --build build --target targets --config Release

cd ..

cp luaubuild/build/Debug/*.a build/luau/macos-debug
cp luaubuild/build/Release/*.a build/luau/macos-release

rm -r luaubuild
