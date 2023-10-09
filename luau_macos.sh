#! /bin/sh

set -e

mkdir -p build/luau/macos-debug
mkdir -p build/luau/macos-release

flags="-DLUAU_BUILD_CLI=OFF -DLUAU_BUILD_TESTS=OFF"

cp -r luau-0.524 luaubuild
cd luaubuild

cmake -Bbuild -GXcode -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" -DCMAKE_OSX_DEPLOYMENT_TARGET=10.15 .
cmake --build build --config Debug
cmake --build build --config Release

cd ..

cp luaubuild/build/Debug/libLuau.Ast.a luaubuild/build/Debug/libLuau.Compiler.a luaubuild/build/Debug/libLuau.VM.a build/luau/macos-debug
cp luaubuild/build/Release/libLuau.Ast.a luaubuild/build/Release/libLuau.Compiler.a luaubuild/build/Release/libLuau.VM.a build/luau/macos-release

rm -r luaubuild
