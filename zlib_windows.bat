mkdir build
mkdir build\zlib
mkdir build\zlib\windows-debug
mkdir build\zlib\windows-release

robocopy zlib-1.2.11 zlibbuild /E /NFL /NDL /NJH /NJS /NP
cd zlibbuild

echo string(REPLACE "/MD" "/MT" CMAKE_C_FLAGS_DEBUG "${CMAKE_C_FLAGS_DEBUG}") >> CMakeLists.txt
echo string(REPLACE "/MD" "/MT" CMAKE_C_FLAGS_RELEASE "${CMAKE_C_FLAGS_RELEASE}") >> CMakeLists.txt

cmake -G "Visual Studio 16 2019" -A x64 .
msbuild /maxcpucount ALL_BUILD.vcxproj
msbuild /maxcpucount /p:Configuration=Release ALL_BUILD.vcxproj

cd ..

copy zlibbuild\Debug\zlibstaticd.lib build\zlib\windows-debug\zlib.lib
copy zlibbuild\Debug\zlibstaticd.pdb build\zlib\windows-debug

copy zlibbuild\Release\zlibstatic.lib build\zlib\windows-release\zlib.lib

rmdir /S /Q zlibbuild
