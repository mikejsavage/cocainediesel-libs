mkdir build
mkdir build\openal
mkdir build\openal\windows-debug
mkdir build\openal\windows-release

set FLAGS=%FLAGS% -DLIBTYPE=STATIC
set FLAGS=%FLAGS% -DALSOFT_UTILS=OFF
set FLAGS=%FLAGS% -DALSOFT_EXAMPLES=OFF
set FLAGS=%FLAGS% -DALSOFT_TESTS=OFF
set FLAGS=%FLAGS% -DALSOFT_AMBDEC_PRESETS=OFF

robocopy openal-soft-openal-soft-1.19.1 openalbuild /E
cd openalbuild

cmake -G "Visual Studio 14 2015 Win64" %FLAGS% .
dir
msbuild /maxcpucount ALL_BUILD.vcxproj
msbuild /maxcpucount /p:Configuration=Release ALL_BUILD.vcxproj

dir Debug
dir Release

cd ..

rmdir /S /Q openalbuild
