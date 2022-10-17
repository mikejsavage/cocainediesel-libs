#! /bin/sh

set -e

mkdir -p build/mbedtls/linux-debug
mkdir -p build/mbedtls/linux-release

flags="-DENABLE_PROGRAMS=OFF -DENABLE_TESTING=OFF"

cp -r mbedtls-3.2.1 mbedtlsbuild
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

cp mbedtlsbuild/debugbuild/lib64/*.a build/mbedtls/linux-debug
cp mbedtlsbuild/releasebuild/lib64/*.a build/mbedtls/linux-release

cp -r mbedtlsbuild/include/mbedtls build/mbedtls
cp -r mbedtlsbuild/include/psa build/mbedtls
