#! /bin/sh

set -e

mkdir -p build/freetype/macos-debug
mkdir -p build/freetype/macos-release

flags="\
-DBUILD_SHARED_LIBS=OFF \
-DCMAKE_DISABLE_FIND_PACKAGE_BrotliDec=TRUE \
-DCMAKE_DISABLE_FIND_PACKAGE_BZip2=TRUE \
-DCMAKE_DISABLE_FIND_PACKAGE_HarfBuzz=TRUE \
-DCMAKE_DISABLE_FIND_PACKAGE_PNG=TRUE \
-DCMAKE_DISABLE_FIND_PACKAGE_ZLIB=TRUE"

cp -r freetype-2.13.2 freetypebuild
cd freetypebuild

cmake -Bbuild -GXcode -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" -DCMAKE_OSX_DEPLOYMENT_TARGET=10.15 $flags .
cmake --build build --config Debug
cmake --build build --config Release

cd ..

cp freetypebuild/build/Debug/libfreetype.a build/freetype/macos-debug
cp freetypebuild/build/Release/libfreetype.a build/freetype/macos-release

rm -r freetypebuild
