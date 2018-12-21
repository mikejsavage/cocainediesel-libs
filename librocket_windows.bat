mkdir build
mkdir build\librocket
mkdir build\librocket\windows-debug
mkdir build\librocket\windows-release

set FLAGS=
set FLAGS=%FLAGS% -DBUILD_SHARED_LIBS=OFF
REM always optimise for size because otherwise the debug libs are 100MB
set FLAGS=%FLAGS% -DCMAKE_CXX_FLAGS_DEBUG="/O1 /MDd" -DCMAKE_CXX_FLAGS_RELEASE="/O1"

robocopy libRocket librocketbuild /E /NFL /NDL /NJH /NJS /NP
cd librocketbuild\Build

cmake -G "Visual Studio 14 2015 Win64" %FLAGS% .
msbuild /maxcpucount /p:DebugSymbols=false RocketCore.vcxproj
msbuild /maxcpucount /p:DebugSymbols=false RocketControls.vcxproj
msbuild /maxcpucount /p:Configuration=Release RocketCore.vcxproj
msbuild /maxcpucount /p:Configuration=Release RocketControls.vcxproj

cd ..\..

copy librocketbuild\Build\Debug\RocketCore.lib build\librocket\windows-debug
copy librocketbuild\Build\Debug\RocketControls.lib build\librocket\windows-debug

copy librocketbuild\Build\Release\RocketCore.lib build\librocket\windows-release
copy librocketbuild\Build\Release\RocketControls.lib build\librocket\windows-release

rmdir /S /Q librocketbuild
