#! /bin/sh

set -e

mkdir -p build/freetype/linux-debug
mkdir -p build/freetype/linux-release

flags="\
-DBUILD_SHARED_LIBS=OFF \
-DCMAKE_DISABLE_FIND_PACKAGE_BrotliDec=TRUE \
-DCMAKE_DISABLE_FIND_PACKAGE_BZip2=TRUE \
-DCMAKE_DISABLE_FIND_PACKAGE_HarfBuzz=TRUE \
-DCMAKE_DISABLE_FIND_PACKAGE_PNG=TRUE \
-DCMAKE_DISABLE_FIND_PACKAGE_ZLIB=TRUE"

cp -r freetype-2.13.2 freetypebuild
cd freetypebuild

cmake -Bdebugbuild $flags
cmake --build debugbuild --config Debug --parallel $(nproc --all)
cmake -Breleasebuild $flags
cmake --build releasebuild --config Release --parallel $(nproc --all)

cd ..

cp freetypebuild/debugbuild/libfreetype.a build/freetype/linux-debug
cp freetypebuild/releasebuild/libfreetype.a build/freetype/linux-release

cp -r freetype-2.13.2/include/* build/freetype
cp -r freetypebuild/debugbuild/include/* build/freetype

rm -r freetypebuild
