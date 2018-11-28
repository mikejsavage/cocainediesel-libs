#! /bin/sh

set -e

flags="-DENABLE_PROGRAMS=OFF -DENABLE_TESTING=OFF"

cp -r mbedtls-2.15.0 mbedtlsbuild
cd mbedtlsbuild

mkdir debugbuild
cd debugbuild
cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=. $flags ..
make -j$(nproc --all)
make install
cd ..

mkdir releasebuild
cd releasebuild
cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=. $flags ..
make -j$(nproc --all)
make install
cd ..

cd ..
