#! /bin/sh

set -e

mkdir -p build/openal/macos-debug
mkdir -p build/openal/macos-release

flags="\
-DLIBTYPE=STATIC \
-DALSOFT_UTILS=OFF \
-DALSOFT_EXAMPLES=OFF \
-DALSOFT_NO_CONFIG_UTIL=ON"

cp -r openal-soft-1.21.1 openalbuild
cd openalbuild

cmake -Bbuild -GXcode -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" -DCMAKE_OSX_DEPLOYMENT_TARGET=10.13 $flags .
cmake --build build --config Debug
cmake --build build --config Release

cd ..

cp openalbuild/build/Debug/libopenal.a build/openal/macos-debug
cp openalbuild/build/Release/libopenal.a build/openal/macos-release

rm -r openalbuild