#! /bin/sh

set -e

mkdir -p build/mbedtls/linux-debug
mkdir -p build/mbedtls/linux-release

flags="-DENABLE_PROGRAMS=OFF -DENABLE_TESTING=OFF"

cp -r mbedtls-3.5.1 mbedtlsbuild
cd mbedtlsbuild

cmake -Bdebugbuild $flags
cmake --build debugbuild --config Debug --parallel $(nproc --all)
cmake --install debugbuild --prefix debugbuild
cmake -Breleasebuild $flags
cmake --build releasebuild --config Release --parallel $(nproc --all)
cmake --install releasebuild --prefix releasebuild

cd ..

cp mbedtlsbuild/debugbuild/library/*.a build/mbedtls/linux-debug
cp mbedtlsbuild/releasebuild/library/*.a build/mbedtls/linux-release

cp -r mbedtlsbuild/include/mbedtls build/mbedtls
cp -r mbedtlsbuild/include/psa build/mbedtls
