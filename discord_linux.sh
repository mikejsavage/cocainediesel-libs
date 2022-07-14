#! /bin/sh

set -e

mkdir -p build/discord/linux-debug
mkdir -p build/discord/linux-release

cp -r discord-rpc discordbuild
cd discordbuild

mkdir debugbuild
cd debugbuild
cmake -DCMAKE_BUILD_TYPE=Debug ..
make -j$(nproc --all)
cd ..

mkdir releasebuild
cd releasebuild
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j$(nproc --all)
cd ..

cd ..

cp discordbuild/debugbuild/libdiscord.a build/discord/linux-debug
cp discordbuild/releasebuild/libdiscord.a build/discord/linux-release

rm -r discordbuild

cp discord-rpc/discord_rpc.h build/discord
