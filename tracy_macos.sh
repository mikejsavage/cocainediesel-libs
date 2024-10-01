#! /bin/sh

set -e

mkdir -p build/tracy/macos-debug
mkdir -p build/tracy/macos-release

flags="-DTRACY_STATIC=ON"

cp -r tracy-0.11.1 tracybuild
cd tracybuild

cmake -Bdebugbuild -GXcode -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" -DCMAKE_OSX_DEPLOYMENT_TARGET=10.15 $flags
cmake --build debugbuild --config Debug
cmake -Breleasebuild -GXcode -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" -DCMAKE_OSX_DEPLOYMENT_TARGET=10.15 $flags -DTRACY_ENABLE=OFF
cmake --build releasebuild --config Release

cd profiler
cmake -Bbuild -GXcode -DCMAKE_OSX_DEPLOYMENT_TARGET=10.15
cmake --build build --config Release
cd ..

cd ..

cp tracybuild/debugbuild/Debug/libTracyClient.a build/tracy/macos-debug/libtracy.a
cp tracybuild/releasebuild/Release/libTracyClient.a build/tracy/macos-release/libtracy.a
cp tracybuild/profiler/build/Release/tracy-profiler build/tracy/Tracy.macos

rm -rf tracybuild
