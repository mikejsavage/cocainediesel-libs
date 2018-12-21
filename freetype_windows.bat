mkdir build
mkdir build\freetype
mkdir build\freetype\windows-debug
mkdir build\freetype\windows-release

set FLAGS=
set FLAGS=%FLAGS% -DBUILD_SHARED_LIBS=OFF
set FLAGS=%FLAGS% -DCMAKE_DISABLE_FIND_PACKAGE_HarfBuzz=TRUE
set FLAGS=%FLAGS% -DCMAKE_DISABLE_FIND_PACKAGE_BZip2=TRUE
set FLAGS=%FLAGS% -DCMAKE_DISABLE_FIND_PACKAGE_PNG=TRUE
set FLAGS=%FLAGS% -DCMAKE_DISABLE_FIND_PACKAGE_ZLIB=TRUE

robocopy freetype-2.9.1 freetypebuild /E /NFL /NDL /NJH /NJS /NP
mkdir freetypebuild\build
cd freetypebuild\build

cmake -G "Visual Studio 14 2015 Win64" %FLAGS% ..
msbuild /maxcpucount ALL_BUILD.vcxproj
msbuild /maxcpucount /p:Configuration=Release ALL_BUILD.vcxproj

cd ..\..

copy freetypebuild\build\Debug\freetyped.lib build\freetype\windows-debug\freetype.lib
copy freetypebuild\build\freetype.dir\Debug\freetype.pdb build\freetype\windows-debug

copy freetypebuild\build\Release\freetype.lib build\freetype\windows-release

rmdir /S /Q freetypebuild
