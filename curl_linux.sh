#! /bin/sh

set -e

./mbedtls_linux.sh

mkdir -p build/curl/linux-debug
mkdir -p build/curl/linux-release

flags="\
--enable-static \
--disable-shared \
--disable-ftp \
--disable-file \
--disable-ldap \
--disable-ldaps \
--disable-rtsp \
--disable-proxy \
--disable-dict \
--disable-telnet \
--disable-tftp \
--disable-pop3 \
--disable-imap \
--disable-smb \
--disable-smtp \
--disable-gopher \
--disable-manual \
--disable-libcurl-option \
--enable-pthreads \
--disable-sspi \
--disable-crypto-auth \
--disable-ntlm-wb \
--disable-tls-srp \
--disable-unix-sockets \
--disable-cookies \
--without-pic \
--without-zlib \
--without-brotli \
--without-default-ssl-backend \
--without-winssl \
--without-ssl \
--without-gnutls \
--without-polarssl \
--without-cyassl \
--without-wolfssl \
--without-mesalink \
--without-nss \
--without-axtls \
--without-ca-bundle \
--without-ca-path \
--without-ca-fallback \
--without-libpsl \
--without-librtmp \
--without-winidn \
--without-libidn2 \
--without-nghttp2"

cp -r curl-7.80.0 curlbuild
cd curlbuild
./configure --enable-debug --disable-optimize --with-mbedtls="$PWD/../mbedtlsbuild/debugbuild" $flags
make -j$(nproc --all)
cd ..

cp curlbuild/lib/.libs/libcurl.a build/curl/linux-debug

rm -r curlbuild

cp -r curl-7.80.0 curlbuild
cd curlbuild
./configure --disable-debug --enable-optimize --with-mbedtls="$PWD/../mbedtlsbuild/releasebuild" $flags
make -j$(nproc --all)
cd ..

cp curlbuild/lib/.libs/libcurl.a build/curl/linux-release

rm -r curlbuild
rm -r mbedtlsbuild

cp curl-7.80.0/include/curl/*.h build/curl
