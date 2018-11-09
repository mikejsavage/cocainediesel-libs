mkdir build
mkdir build\windows-debug
mkdir build\windows-release

robocopy SDL2-2.0.9 sdlbuild /E
mkdir sdlbuild\build
cd sdlbuild\build

cmake -G "Visual Studio 14 2015 Win64" -DFORCE_STATIC_VCRT=ON -DRENDER_D3D=OFF ..
msbuild /maxcpucount SDL2-static.vcxproj
msbuild /maxcpucount /p:Configuration=Release SDL2-static.vcxproj

cd ..\..

cp sdlbuild\build\Debug\SDL2-staticd.lib build\windows-debug\SDL2.lib
cp sdlbuild\build\SDL2-static.dir\Debug\SDL2-static.pdb build\windows-debug\SDL2.pdb
cp sdlbuild\build\Release\SDL2-static.lib build\windows-release\SDL2.lib

rmdir /S /Q sdlbuild
