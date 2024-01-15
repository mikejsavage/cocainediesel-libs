#! /bin/sh

. ./common_linux.sh

grep "REPLACE \"/MD\" \"/MT\"" freetype-2.13.2/CMakeLists.txt

flags="\
-DBUILD_SHARED_LIBS=OFF \
-DCMAKE_DISABLE_FIND_PACKAGE_BrotliDec=TRUE \
-DCMAKE_DISABLE_FIND_PACKAGE_BZip2=TRUE \
-DCMAKE_DISABLE_FIND_PACKAGE_HarfBuzz=TRUE \
-DCMAKE_DISABLE_FIND_PACKAGE_PNG=TRUE \
-DCMAKE_DISABLE_FIND_PACKAGE_ZLIB=TRUE"
standard_cmake freetype freetype-2.13.2 libfreetype*.a "$flags"

mv build/freetype/linux-debug/libfreetyped.a build/freetype/linux-debug/libfreetype.a

cp -r freetype-2.13.2/include/* build/freetype

rm -r freetypebuild
