#! /bin/sh

set -e

mkdir -p build/discord/linux-debug
mkdir -p build/discord/linux-release

cp -r discord-rpc discordbuild
cd discordbuild

cmake -Bdebugbuild
cmake --build debugbuild --config Debug --parallel $(nproc --all)
cmake -Breleasebuild
cmake --build releasebuild --config Release --parallel $(nproc --all)

cd ..

cp discordbuild/debugbuild/libdiscord.a build/discord/linux-debug
cp discordbuild/releasebuild/libdiscord.a build/discord/linux-release

rm -r discordbuild

cp discord-rpc/discord_rpc.h build/discord
