#! /bin/sh

set -e

mkdir -p build/freetype/linux-debug
mkdir -p build/freetype/linux-release

flags="\
-DBUILD_SHARED_LIBS=OFF \
-DCMAKE_DISABLE_FIND_PACKAGE_HarfBuzz=TRUE \
-DCMAKE_DISABLE_FIND_PACKAGE_BZip2=TRUE \
-DCMAKE_DISABLE_FIND_PACKAGE_PNG=TRUE \
-DCMAKE_DISABLE_FIND_PACKAGE_ZLIB=TRUE"

cp -r freetype-2.11.0 freetypebuild
cd freetypebuild

mkdir debugbuild
cd debugbuild
cmake -DCMAKE_BUILD_TYPE=Debug $flags ..
make -j$(nproc --all)
cd ..

mkdir releasebuild
cd releasebuild
cmake -DCMAKE_BUILD_TYPE=Release $flags ..
make -j$(nproc --all)
cd ..

cd ..

cp freetypebuild/debugbuild/libfreetyped.a build/freetype/linux-debug/libfreetype.a
cp freetypebuild/releasebuild/libfreetype.a build/freetype/linux-release

cp -r freetype-2.11.0/include/* build/freetype
cp -r freetypebuild/debugbuild/include/* build/freetype

rm -r freetypebuild
