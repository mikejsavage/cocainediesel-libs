mkdir build
mkdir build\luau
mkdir build\luau\windows-debug
mkdir build\luau\windows-release

set FLAGS=
set FLAGS=%FLAGS% -DLUAU_BUILD_CLI=OFF
set FLAGS=%FLAGS% -DLUAU_BUILD_TESTS=OFF
set FLAGS=%FLAGS% -DLUAU_STATIC_CRT=ON

robocopy luau-0.524 luaubuild /E /NFL /NDL /NJH /NJS /NP
cd luaubuild

cmake -G "Visual Studio 17 2022" -A x64 %FLAGS% .

msbuild /maxcpucount Luau.Compiler.vcxproj
msbuild /maxcpucount Luau.VM.vcxproj
msbuild /maxcpucount /p:Configuration=Release Luau.Compiler.vcxproj
msbuild /maxcpucount /p:Configuration=Release Luau.VM.vcxproj

cd ..

copy luaubuild\Debug\*.lib build\luau\windows-debug\
copy luaubuild\Debug\*.pdb build\luau\windows-debug\
copy luaubuild\Release\*.lib build\luau\windows-release\

rmdir /S /Q luaubuild
