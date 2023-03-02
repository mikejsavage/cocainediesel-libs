mkdir build
mkdir build\freetype
mkdir build\freetype\windows-debug
mkdir build\freetype\windows-release

set FLAGS=
set FLAGS=%FLAGS% -DBUILD_SHARED_LIBS=OFF
set FLAGS=%FLAGS% -DCMAKE_DISABLE_FIND_PACKAGE_BrotliDec=TRUE
set FLAGS=%FLAGS% -DCMAKE_DISABLE_FIND_PACKAGE_BZip2=TRUE
set FLAGS=%FLAGS% -DCMAKE_DISABLE_FIND_PACKAGE_HarfBuzz=TRUE
set FLAGS=%FLAGS% -DCMAKE_DISABLE_FIND_PACKAGE_PNG=TRUE
set FLAGS=%FLAGS% -DCMAKE_DISABLE_FIND_PACKAGE_ZLIB=TRUE

robocopy freetype-2.11.0 freetypebuild /E /NFL /NDL /NJH /NJS /NP
mkdir freetypebuild\build
cd freetypebuild\build

REM Freetype has no static CRT option and no easy way to hack it in from batch
REM So add the following lines above the cpack stuff:
REM string(REPLACE "/MD" "/MT" CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}")
REM string(REPLACE "/MD" "/MT" CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}")

cmake -G "Visual Studio 16 2019" -A x64 %FLAGS% ..
msbuild /maxcpucount ALL_BUILD.vcxproj
msbuild /maxcpucount /p:Configuration=Release ALL_BUILD.vcxproj

cd ..\..

copy freetypebuild\build\Debug\freetyped.lib build\freetype\windows-debug\freetype.lib
copy freetypebuild\build\Debug\freetyped.pdb build\freetype\windows-debug

copy freetypebuild\build\Release\freetype.lib build\freetype\windows-release

rmdir /S /Q freetypebuild
