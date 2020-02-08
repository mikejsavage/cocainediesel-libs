mkdir build
mkdir build\zstd
mkdir build\zstd\windows-debug
mkdir build\zstd\windows-release

set FLAGS=
set FLAGS=%FLAGS% -DZSTD_USE_STATIC_RUNTIME=ON
set FLAGS=%FLAGS% -DZSTD_MULTITHREAD_SUPPORT=OFF
set FLAGS=%FLAGS% -DZSTD_BUILD_PROGRAMS=OFF
set FLAGS=%FLAGS% -DZSTD_BUILD_SHARED=OFF

robocopy zstd-1.4.4 zstdbuild /E /NFL /NDL /NJH /NJS /NP
cd zstdbuild\build\cmake

cmake -G "Visual Studio 16 2019" -A x64 %FLAGS% .
msbuild /maxcpucount /p:Configuration=RelWithDebInfo ALL_BUILD.vcxproj
msbuild /maxcpucount /p:Configuration=Release ALL_BUILD.vcxproj

cd ..\..\..

copy zstdbuild\build\cmake\lib\RelWithDebInfo\zstd_static.lib build\zstd\windows-debug\zstd.lib
copy zstdbuild\build\cmake\lib\libzstd_static.dir\RelWithDebInfo\libzstd_static.pdb build\zstd\windows-debug

copy zstdbuild\build\cmake\lib\Release\zstd_static.lib build\zstd\windows-release\zstd.lib

rmdir /S /Q zstdbuild
