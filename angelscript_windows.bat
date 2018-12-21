mkdir build
mkdir build\angelscrpt
mkdir build\angelscrpt\windows-debug
mkdir build\angelscrpt\windows-release

robocopy angelscript-2.32.0 angelscriptbuild /E /NFL /NDL /NJH /NJS /NP
cd angelscriptbuild\angelscript\projects\cmake

cmake -G "Visual Studio 14 2015 Win64" %FLAGS% .
msbuild /maxcpucount ALL_BUILD.vcxproj
msbuild /maxcpucount /p:Configuration=Release ALL_BUILD.vcxproj

cd ..\..\..\..

dir angelscriptbuild\angelscript\projects\cmake\Debug
dir angelscriptbuild\angelscript\projects\cmake\Release

copy angelscriptbuild\angelscript\projects\cmake\Debug\angelscript.lib build\angelscript\windows-debug

copy angelscriptbuild\angelscript\projects\cmake\Release\angelscript.lib build\angelscript\windows-release

rmdir /S /Q angelscriptbuild
