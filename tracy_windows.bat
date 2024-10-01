mkdir build
mkdir build\tracy

robocopy tracy-0.11.1 tracybuild /E /NFL /NDL /NJH /NJS /NP
cd tracybuild\profiler

cmake -B build -G "Visual Studio 17 2022" -A x64
cmake --build build --config Release

cd ..\..

copy tracybuild\profiler\build\Release\tracy-profiler.exe build\tracy\tracy.exe

rmdir /S /Q tracybuild
