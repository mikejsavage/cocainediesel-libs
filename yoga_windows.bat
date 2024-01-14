mkdir build
mkdir build\yoga
mkdir build\yoga\windows-debug
mkdir build\yoga\windows-release

robocopy yoga-2.0.1 yogabuild /E /NFL /NDL /NJH /NJS /NP
cd yogabuild

cmake -G "Visual Studio 17 2022" -A x64 .
msbuild /maxcpucount yoga.vcxproj
msbuild /maxcpucount /p:Configuration=Release yoga.vcxproj

cd ..

copy yogabuild\Debug\yoga.lib build\yoga\windows-debug
copy yogabuild\Debug\yoga.pdb build\yoga\windows-debug
copy yogabuild\Release\yoga.lib build\yoga\windows-release

rmdir /S /Q yogabuild
