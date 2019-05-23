mkdir build
mkdir build\openal
mkdir build\openal\windows-debug
mkdir build\openal\windows-release

set FLAGS=
set FLAGS=%FLAGS% -DLIBTYPE=STATIC
set FLAGS=%FLAGS% -DFORCE_STATIC_VCRT=ON
set FLAGS=%FLAGS% -DALSOFT_UTILS=OFF
set FLAGS=%FLAGS% -DALSOFT_EXAMPLES=OFF
set FLAGS=%FLAGS% -DALSOFT_TESTS=OFF
set FLAGS=%FLAGS% -DALSOFT_AMBDEC_PRESETS=OFF

robocopy openal-soft-openal-soft-1.19.1 openalbuild /E /NFL /NDL /NJH /NJS /NP
cd openalbuild

cmake -G "Visual Studio 16 2019" -A x64 %FLAGS% .
msbuild /maxcpucount ALL_BUILD.vcxproj
msbuild /maxcpucount /p:Configuration=Release OpenAL.vcxproj

cd ..

copy openalbuild\Debug\OpenAL32.lib build\openal\windows-debug\openal.lib
copy openalbuild\OpenAL.dir\Debug\OpenAL.pdb build\openal\windows-debug

copy openalbuild\Release\OpenAL32.lib build\openal\windows-release\openal.lib

rmdir /S /Q openalbuild
