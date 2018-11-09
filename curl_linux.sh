#! /bin/sh

mkdir -p build/linux-debug
mkdir -p build/linux-release

flags=
flags+=" --enable-static"
flags+=" --disable-shared"
flags+=" --disable-ftp"
flags+=" --disable-file"
flags+=" --disable-ldap"
flags+=" --disable-ldaps"
flags+=" --disable-rtsp"
flags+=" --disable-proxy"
flags+=" --disable-dict"
flags+=" --disable-telnet"
flags+=" --disable-tftp"
flags+=" --disable-pop3"
flags+=" --disable-imap"
flags+=" --disable-smb"
flags+=" --disable-smtp"
flags+=" --disable-gopher"
flags+=" --disable-manual"
flags+=" --disable-libcurl-option"
flags+=" --enable-pthreads"
flags+=" --disable-sspi"
flags+=" --disable-crypto-auth"
flags+=" --disable-ntlm-wb"
flags+=" --disable-tls-srp"
flags+=" --disable-unix-sockets"
flags+=" --disable-cookies"
flags+=" --without-zlib"
flags+=" --without-brotli"
flags+=" --without-default-ssl-backend"
flags+=" --without-winssl"
flags+=" --without-darwinssl"
flags+=" --without-ssl"
flags+=" --without-gnutls"
flags+=" --without-polarssl"
flags+=" --without-mbedtls"
flags+=" --without-cyassl"
flags+=" --without-wolfssl"
flags+=" --without-mesalink"
flags+=" --without-nss"
flags+=" --without-axtls"
flags+=" --without-ca-bundle"
flags+=" --without-ca-path"
flags+=" --without-ca-fallback"
flags+=" --without-libpsl"
flags+=" --without-libmetalink"
flags+=" --without-librtmp"
flags+=" --without-winidn"
flags+=" --without-libidn2"
flags+=" --without-nghttp2"
#flags+=" --enable-verbose"
#flags+=" --disable-verbose"

cp -r curl-7.62.0 curlbuild
cd curlbuild
./configure --enable-debug --disable-optimize $flags
make -j$(nproc --all)
cd ..
cp curlbuild/lib/.libs/libcurl.a build/linux-debug

rm -r curlbuild

cp -r curl-7.62.0 curlbuild
cd curlbuild
./configure --disable-debug --enable-optimize $flags
make -j$(nproc --all)
cd ..
cp curlbuild/lib/.libs/libcurl.a build/linux-release

rm -r curlbuild
