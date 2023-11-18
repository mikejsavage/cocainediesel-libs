mkdir build
mkdir build\openal
mkdir build\openal\windows-debug
mkdir build\openal\windows-release

set FLAGS=
set FLAGS=%FLAGS% -DLIBTYPE=STATIC
set FLAGS=%FLAGS% -DFORCE_STATIC_VCRT=ON
set FLAGS=%FLAGS% -DALSOFT_REQUIRE_SSE4_1=ON
set FLAGS=%FLAGS% -DALSOFT_BACKEND_WINMM=OFF
set FLAGS=%FLAGS% -DALSOFT_BACKEND_DSOUND=OFF
set FLAGS=%FLAGS% -DALSOFT_BACKEND_WASAPI=OFF
set FLAGS=%FLAGS% -DALSOFT_BACKEND_WAVE=OFF
set FLAGS=%FLAGS% -DALSOFT_UTILS=OFF
set FLAGS=%FLAGS% -DALSOFT_EXAMPLES=OFF
set FLAGS=%FLAGS% -DALSOFT_NO_CONFIG_UTIL=ON
set FLAGS=%FLAGS% -DALSOFT_INSTALL_AMBDEC_PRESETS=OFF

robocopy openal-soft-1.23.1 openalbuild /E /NFL /NDL /NJH /NJS /NP
cd openalbuild

cmake -G "Visual Studio 17 2022" -A x64 %FLAGS% .
msbuild /maxcpucount ALL_BUILD.vcxproj
msbuild /maxcpucount /p:Configuration=Release OpenAL.vcxproj

cd ..

copy openalbuild\Debug\OpenAL32.lib build\openal\windows-debug\openal.lib
copy openalbuild\Debug\OpenAL32.pdb build\openal\windows-debug

copy openalbuild\Release\OpenAL32.lib build\openal\windows-release\openal.lib

rmdir /S /Q openalbuild
