REM we can't do a debug build because librocket PDBs are too big

mkdir build
mkdir build\librocket
mkdir build\librocket\windows-debug
mkdir build\librocket\windows-release

set FLAGS=-DBUILD_SHARED_LIBS=OFF

robocopy libRocket librocketbuild /E /NFL /NDL /NJH /NJS /NP
cd librocketbuild\Build

cmake -G "Visual Studio 14 2015 Win64" %FLAGS% .
msbuild /maxcpucount /p:Configuration=Release ALL_BUILD.vcxproj

cd ..\..

copy librocketbuild\Build\Release\RocketCore.lib build\librocket\windows-debug
copy librocketbuild\Build\Release\RocketControls.lib build\librocket\windows-debug

copy librocketbuild\Build\Release\RocketCore.lib build\librocket\windows-release
copy librocketbuild\Build\Release\RocketControls.lib build\librocket\windows-release

rmdir /S /Q librocketbuild
