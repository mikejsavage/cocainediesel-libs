mkdir build
mkdir build\sdl
mkdir build\sdl\windows-debug
mkdir build\sdl\windows-release

set FLAGS=%FLAGS% -DSDL_SHARED=OFF
set FLAGS=%FLAGS% -DFORCE_STATIC_VCRT=ON
set FLAGS=%FLAGS% -DRENDER_D3D=OFF 

robocopy SDL2-2.0.9 sdlbuild /E
mkdir sdlbuild\build
cd sdlbuild\build

cmake -G "Visual Studio 14 2015 Win64" %FLAGS% ..
msbuild /maxcpucount SDL2-static.vcxproj
msbuild /maxcpucount /p:Configuration=Release SDL2-static.vcxproj

cd ..\..

cp sdlbuild\build\Debug\SDL2d.lib build\sdl\windows-debug\SDL2.lib
cp sdlbuild\build\SDL2-static.dir\Debug\SDL2-static.pdb build\sdl\windows-debug\SDL2.pdb
cp sdlbuild\build\Release\SDL2.lib build\sdl\windows-release\SDL2.lib

rmdir /S /Q sdlbuild
