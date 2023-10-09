#! /bin/sh

set -e

mkdir -p build/discord/macos-debug
mkdir -p build/discord/macos-release

cp -r discord-rpc discordbuild
cd discordbuild

cmake -Bbuild -GXcode -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" -DCMAKE_OSX_DEPLOYMENT_TARGET=10.15 .
cmake --build build --config Debug
cmake --build build --config Release

cd ..

cp discordbuild/build/Debug/libdiscord.a build/discord/macos-debug
cp discordbuild/build/Release/libdiscord.a build/discord/macos-release

rm -r discordbuild
