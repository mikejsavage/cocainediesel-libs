mkdir build
mkdir build\yoga
mkdir build\yoga\windows-debug
mkdir build\yoga\windows-release

robocopy yoga-1.19.0 yogabuild /E /NFL /NDL /NJH /NJS /NP
cd yogabuild

cmake -G "Visual Studio 16 2019" -A x64 .
msbuild /maxcpucount yoga.vcxproj
msbuild /maxcpucount /p:Configuration=Release yoga.vcxproj

cd ..

copy yogabuild\Debug\yoga.lib build\yoga\windows-debug
copy yogabuild\Debug\yoga.pdb build\yoga\windows-debug
copy yogabuild\Release\yoga.lib build\yoga\windows-release

rmdir /S /Q yogabuild
