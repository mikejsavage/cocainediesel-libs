#! /bin/sh

. ./common_linux.sh

standard_cmake discord discord-rpc libdiscord.a

cp discord-rpc/discord_rpc.h build/discord

rm -r discordbuild
