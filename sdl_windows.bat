mkdir build
mkdir build\sdl
mkdir build\sdl\windows-debug
mkdir build\sdl\windows-release

set FLAGS=
set FLAGS=%FLAGS% "-DCMAKE_MSVC_RUNTIME_LIBRARY=MultiThreaded$<$<CONFIG:Debug>:Debug>"
set FLAGS=%FLAGS% -DUSE_MSVC_RUNTIME_LIBRARY_DLL=OFF
set FLAGS=%FLAGS% -DSDL_SHARED=OFF
set FLAGS=%FLAGS% -DSDL_STATIC=ON
set FLAGS=%FLAGS% -DSDL_TEST_LIBRARY=OFF

set FLAGS=%FLAGS% -DSDL_AUDIO=ON
set FLAGS=%FLAGS% -DSDL_VIDEO=ON
set FLAGS=%FLAGS% -DSDL_GPU=OFF
set FLAGS=%FLAGS% -DSDL_RENDER=OFF
set FLAGS=%FLAGS% -DSDL_CAMERA=OFF
set FLAGS=%FLAGS% -DSDL_JOYSTICK=ON
set FLAGS=%FLAGS% -DSDL_HAPTIC=OFF
set FLAGS=%FLAGS% -DSDL_HIDAPI=OFF
set FLAGS=%FLAGS% -DSDL_POWER=OFF
set FLAGS=%FLAGS% -DSDL_SENSOR=OFF
set FLAGS=%FLAGS% -DSDL_DIALOG=OFF

set FLAGS=%FLAGS% -DSDL_DUMMYAUDIO=OFF
set FLAGS=%FLAGS% -DSDL_DUMMYVIDEO=OFF
set FLAGS=%FLAGS% -DSDL_DISKAUDIO=OFF
set FLAGS=%FLAGS% -DSDL_OFFSCREEN=OFF
set FLAGS=%FLAGS% -DSDL_OPENGLES=OFF

robocopy SDL-3.2.4 sdlbuild /E /NFL /NDL /NJH /NJS /NP
mkdir sdlbuild\build
cd sdlbuild\build

cmake -G "Visual Studio 17 2022" -A x64 %FLAGS% ..
msbuild /maxcpucount ALL_BUILD.vcxproj
msbuild /maxcpucount /p:Configuration=Release ALL_BUILD.vcxproj

cd ..\..

copy sdlbuild\build\Debug\* build\sdl\windows-debug
copy sdlbuild\build\Release\* build\sdl\windows-release

rmdir /S /Q sdlbuild
