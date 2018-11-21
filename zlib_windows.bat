mkdir build
mkdir build\zlib
mkdir build\zlib\windows-debug
mkdir build\zlib\windows-release

robocopy zlib-1.2.11 zlibbuild /E /NFL /NDL /NJH /NJS /NP
cd zlibbuild

cmake -G "Visual Studio 14 2015 Win64" .
msbuild /maxcpucount ALL_BUILD.vcxproj
msbuild /maxcpucount /p:Configuration=Release ALL_BUILD.vcxproj

cd ..

copy zlibbuild\Debug\zlibstaticd.lib build\zlib\windows-debug\zlib.lib
copy zlibbuild\zlibstatic.dir\Debug\zlibstatic.pdb build\zlib\windows-debug\zlib.pdb

copy zlibbuild\Release\zlibstatic.lib build\zlib\windows-release\zlib.lib

rmdir /S /Q zlibbuild
