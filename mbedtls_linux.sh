#! /bin/sh

set -e

mkdir -p build/mbedtls/linux-debug
mkdir -p build/mbedtls/linux-release

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

cp mbedtlsbuild/debugbuild/lib/*.a build/mbedtls/linux-debug
cd build/mbedtls/linux-debug
ar x libmbedtls.a
ar x libmbedcrypto.a
ar x libmbedx509.a
rm *.a
ar rs libmbedtls.a *.o
rm *.o
cd ../../..

cp mbedtlsbuild/releasebuild/lib/*.a build/mbedtls/linux-release
cd build/mbedtls/linux-release
ar x libmbedtls.a
ar x libmbedcrypto.a
ar x libmbedx509.a
rm *.a
ar rs libmbedtls.a *.o
rm *.o
cd ../../..
