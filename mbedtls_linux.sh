#! /bin/sh

. ./common_linux.sh

flags="-DENABLE_PROGRAMS=OFF -DENABLE_TESTING=OFF"
standard_cmake mbedtls mbedtls-3.5.1 "library/*.a" "$flags"

cp -r mbedtls-3.5.1/include/mbedtls build/mbedtls
cp -r mbedtls-3.5.1/include/psa build/mbedtls
