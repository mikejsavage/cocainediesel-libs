#! /usr/bin/env bash

set -eou pipefail

cd "$(dirname "$0")"

version="$(cat zig_version.txt)"

if [ -e "zig-$version/zig" ]; then
	exit
fi

wget --continue "https://ziglang.org/download/$version/zig-linux-x86_64-$version.tar.xz"
echo "2d00e789fec4f71790a6e7bf83ff91d564943c5ee843c5fd966efc474b423047 zig-linux-x86_64-$version.tar.xz" | sha256sum -c
tar --touch --no-same-owner -xf "zig-linux-x86_64-$version.tar.xz"
rm "zig-linux-x86_64-$version.tar.xz"

# ninja makes the zig dir for some reason, --no-target-directory overwrites an existing empty dir
mv --no-target-directory "zig-linux-x86_64-$version" "zig-$version"

cat << EOF > zig.cmake
set(CMAKE_C_COMPILER "$(pwd)/zig-$version/zig" cc -target x86_64-linux-musl)
set(CMAKE_CXX_COMPILER "$(pwd)/zig-$version/zig" c++ -target x86_64-linux-musl)
set(CMAKE_AR "$(pwd)/ar")
set(CMAKE_RANLIB "$(pwd)/ranlib")
EOF
