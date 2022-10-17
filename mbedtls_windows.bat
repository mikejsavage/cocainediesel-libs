mkdir build
mkdir build\mbedtls
mkdir build\mbedtls\windows-debug
mkdir build\mbedtls\windows-release

robocopy mbedtls-3.2.1 mbedtlsbuild /E /NFL /NDL /NJH /NJS /NP
cd mbedtlsbuild

cmake -G "Visual Studio 16 2019" -A x64 -DSTATIC_CRT=ON -DENABLE_PROGRAMS=OFF -DENABLE_TESTING=OFF .
msbuild /maxcpucount ALL_BUILD.vcxproj
msbuild /maxcpucount /p:Configuration=Release ALL_BUILD.vcxproj

cd ..

copy mbedtlsbuild\library\Debug\*.lib build\mbedtls\windows-debug
copy mbedtlsbuild\library\Debug\*.pdb build\mbedtls\windows-debug
copy mbedtlsbuild\library\Release\*.lib build\mbedtls\windows-release

rmdir /S /Q mbedtlsbuild
