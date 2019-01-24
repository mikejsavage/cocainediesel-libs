mkdir build
mkdir build\sdl
mkdir build\sdl\windows-debug
mkdir build\sdl\windows-release

set FLAGS=
set FLAGS=%FLAGS% -DSDL_SHARED=OFF
REM set FLAGS=%FLAGS% -DFORCE_STATIC_VCRT=ON
set FLAGS=%FLAGS% -DSDL_AUDIO_ENABLED_BY_DEFAULT=OFF
set FLAGS=%FLAGS% -DSDL_RENDER_ENABLED_BY_DEFAULT=OFF
set FLAGS=%FLAGS% -DINPUT_TSLIB=OFF
set FLAGS=%FLAGS% -DVIDEO_DUMMY=OFF
set FLAGS=%FLAGS% -DVIDEO_OPENGLES=OFF
set FLAGS=%FLAGS% -DVIDEO_VULKAN=OFF

robocopy SDL2-2.0.9 sdlbuild /E /NFL /NDL /NJH /NJS /NP
mkdir sdlbuild\build
cd sdlbuild\build

cmake -G "Visual Studio 14 2015 Win64" %FLAGS% ..
msbuild /maxcpucount ALL_BUILD.vcxproj
msbuild /maxcpucount /p:Configuration=Release ALL_BUILD.vcxproj

cd ..\..

copy sdlbuild\build\Debug\SDL2d.lib build\sdl\windows-debug
copy sdlbuild\build\Debug\SDL2maind.lib build\sdl\windows-debug
copy sdlbuild\build\SDL2main.dir\Debug\SDL2main.pdb build\sdl\windows-debug
copy sdlbuild\build\SDL2-static.dir\Debug\SDL2-static.pdb build\sdl\windows-debug

copy sdlbuild\build\Release\SDL2.lib build\sdl\windows-release
copy sdlbuild\build\Release\SDL2main.lib build\sdl\windows-release

cd build\sdl\windows-debug
lib -OUT:sdl.lib SDL2d.lib SDL2maind.lib
del SDL2d.lib SDL2maind.lib

cd ..\windows-release
lib -OUT:sdl.lib SDL2.lib SDL2main.lib
del SDL2.lib SDL2main.lib

cd ..\..\..

rmdir /S /Q sdlbuild
