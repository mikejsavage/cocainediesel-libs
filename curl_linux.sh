#! /bin/sh

. ./common_linux.sh

./mbedtls_linux.sh

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
standard_cmake curl curl-8.5.0 lib/libcurl.a "$flags"

cp curl-8.5.0/include/curl/*.h build/curl

rm -r curlbuild
rm -r mbedtlsbuild
