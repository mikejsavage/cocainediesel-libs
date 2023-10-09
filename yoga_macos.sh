#! /bin/sh

set -e

mkdir -p build/yoga/macos-debug
mkdir -p build/yoga/macos-release

cp -r yoga-1.19.0 yogabuild
cd yogabuild

cmake -Bbuild -GXcode -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" -DCMAKE_OSX_DEPLOYMENT_TARGET=10.15 .
cmake --build build --config Debug
cmake --build build --config Release

cd ..

cp yogabuild/build/Debug/libyoga.a build/yoga/macos-debug
cp yogabuild/build/Release/libyoga.a build/yoga/macos-release

rm -r yogabuild
