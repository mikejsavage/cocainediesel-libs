#! /bin/sh

set -e

./mbedtls_linux.sh

mkdir -p build/curl/linux-debug
mkdir -p build/curl/linux-release

flags="\
-DBUILD_CURL_EXE=OFF \
-DBUILD_SHARED_LIBS=OFF \
-DHTTP_ONLY=ON \
-DCURL_ZLIB=OFF \
-DCURL_USE_OPENSSL=OFF \
-DCURL_USE_MBEDTLS=ON \
-DMBEDTLS_INCLUDE_DIRS=../mbedtls-3.5.1/include \
-DMBEDTLS_LIBRARY=../build/mbedtls/linux-release/mbedtls.lib \
-DMBEDX509_LIBRARY=../build/mbedtls/linux-release/mbedx509.lib \
-DMBEDCRYPTO_LIBRARY=../build/mbedtls/linux-release/mbedcrypto.lib"

cp -r curl-8.5.0 curlbuild
cd curlbuild

cmake -Bdebugbuild $flags
cmake --build debugbuild --config Debug --parallel $(nproc --all)
cmake -Breleasebuild $flags
cmake --build releasebuild --config Release --parallel $(nproc --all)

cd ..

cp curlbuild/debugbuild/lib/libcurl.a build/curl/linux-debug
cp curlbuild/releasebuild/lib/libcurl.a build/curl/linux-release

rm -r curlbuild
rm -r mbedtlsbuild

cp curl-8.5.0/include/curl/*.h build/curl
