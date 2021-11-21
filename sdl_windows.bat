mkdir build
mkdir build\sdl2
mkdir build\sdl2\windows-debug
mkdir build\sdl2\windows-release

set FLAGS=
set FLAGS=%FLAGS% -DSDL_SHARED=OFF
set FLAGS=%FLAGS% -DFORCE_STATIC_VCRT=ON
set FLAGS=%FLAGS% -DSDL_AUDIO_ENABLED_BY_DEFAULT=OFF
set FLAGS=%FLAGS% -DSDL_RENDER_ENABLED_BY_DEFAULT=OFF
set FLAGS=%FLAGS% -DINPUT_TSLIB=OFF
set FLAGS=%FLAGS% -DVIDEO_DUMMY=OFF
set FLAGS=%FLAGS% -DVIDEO_OPENGLES=OFF
set FLAGS=%FLAGS% -DVIDEO_VULKAN=OFF

robocopy SDL2-2.0.14 sdlbuild /E /NFL /NDL /NJH /NJS /NP
mkdir sdlbuild\build
cd sdlbuild\build

cmake -G "Visual Studio 16 2019" -A x64 %FLAGS% ..
msbuild /maxcpucount ALL_BUILD.vcxproj
msbuild /maxcpucount /p:Configuration=Release ALL_BUILD.vcxproj

cd ..\..

copy sdlbuild\build\Debug\SDL2d.lib build\sdl2\windows-debug\SDL2.lib
copy sdlbuild\build\Debug\SDL2-static.pdb build\sdl2\windows-debug

copy sdlbuild\build\Release\SDL2.lib build\sdl2\windows-release\SDL2.lib

rmdir /S /Q sdlbuild
