mkdir build
mkdir build\angelscript
mkdir build\angelscript\windows-debug
mkdir build\angelscript\windows-release

robocopy angelscript-2.29.2 angelscriptbuild /E /NFL /NDL /NJH /NJS /NP
cd angelscriptbuild\angelscript\projects\cmake

echo string(REPLACE "/MD" "/MT" CMAKE_CXX_FLAGS_DEBUG "${CMAKE_CXX_FLAGS_DEBUG}") >> CMakeLists.txt
echo string(REPLACE "/MD" "/MT" CMAKE_CXX_FLAGS_RELEASE "${CMAKE_CXX_FLAGS_RELEASE}") >> CMakeLists.txt

cmake -G "Visual Studio 16 2019" -A x64 %FLAGS% .
msbuild /maxcpucount Angelscript.vcxproj
msbuild /maxcpucount /p:Configuration=Release Angelscript.vcxproj

cd ..\..\..\..

copy angelscriptbuild\angelscript\lib\Debug\Angelscript.lib build\angelscript\windows-debug\angelscript.lib

copy angelscriptbuild\angelscript\lib\Release\Angelscript.lib build\angelscript\windows-release\angelscript.lib

rmdir /S /Q angelscriptbuild
