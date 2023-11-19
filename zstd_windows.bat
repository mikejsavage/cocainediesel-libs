mkdir build
mkdir build\zstd
mkdir build\zstd\windows-debug
mkdir build\zstd\windows-release

set FLAGS=
set FLAGS=%FLAGS% -DZSTD_USE_STATIC_RUNTIME=ON
set FLAGS=%FLAGS% -DZSTD_MULTITHREAD_SUPPORT=OFF
set FLAGS=%FLAGS% -DZSTD_BUILD_PROGRAMS=OFF
set FLAGS=%FLAGS% -DZSTD_BUILD_SHARED=OFF

robocopy zstd-1.5.4 zstdbuild /E /NFL /NDL /NJH /NJS /NP
cd zstdbuild\build\cmake

cmake -G "Visual Studio 17 2022" -A x64 %FLAGS% .

rem Don't link against any CRT. RelWithDebInfo links a release CRT (/MT) and we want it for debug builds of the game (/MTd)
rem The subset of zstd we use doesn't need the CRT so this works out ok
set CL=/Zl
msbuild /maxcpucount /p:Configuration=RelWithDebInfo ALL_BUILD.vcxproj
msbuild /maxcpucount /p:Configuration=Release ALL_BUILD.vcxproj
set CL=

cd ..\..\..

copy zstdbuild\build\cmake\lib\RelWithDebInfo\zstd_static.lib build\zstd\windows-debug\zstd.lib
copy zstdbuild\build\cmake\lib\RelWithDebInfo\zstd_static.pdb build\zstd\windows-debug

copy zstdbuild\build\cmake\lib\Release\zstd_static.lib build\zstd\windows-release\zstd.lib

rmdir /S /Q zstdbuild
