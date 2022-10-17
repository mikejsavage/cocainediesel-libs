mbedtls_windows.bat

mkdir build
mkdir build\curl
mkdir build\curl\windows-debug
mkdir build\curl\windows-release

set FLAGS=
set FLAGS=%FLAGS% -DBUILD_CURL_EXE=OFF
set FLAGS=%FLAGS% -DBUILD_SHARED_LIBS=OFF
set FLAGS=%FLAGS% -DCURL_STATIC_CRT=ON
set FLAGS=%FLAGS% -DHTTP_ONLY=ON
set FLAGS=%FLAGS% -DCURL_ZLIB=OFF

REM schannel started to shit itself for no reason so we use mbedtls on windows too
set FLAGS=%FLAGS% -DCURL_USE_MBEDTLS=ON

set FLAGS=%FLAGS% -DCURL_WINDOWS_SSPI=OFF


REM cmake is trash so we have to split into debug build...

robocopy curl-7.85.0 curlbuild /E /NFL /NDL /NJH /NJS /NP
cd curlbuild

cmake -G "Visual Studio 16 2019" -A x64 %FLAGS% -DMBEDTLS_INCLUDE_DIRS=..\mbedtls-3.2.1\include -DMBEDTLS_LIBRARY=..\build\mbedtls\windows-debug\mbedtls.lib -DMBEDX509_LIBRARY=..\build\mbedtls\windows-debug\mbedx509.lib -DMBEDCRYPTO_LIBRARY=..\build\mbedtls\windows-debug\mbedcrypto.lib .
cd lib
msbuild /maxcpucount libcurl.vcxproj

cd ..\..

copy curlbuild\lib\Debug\libcurl-d.lib build\curl\windows-debug\curl.lib
copy curlbuild\lib\libcurl.dir\Debug\libcurl.pdb build\curl\windows-debug

rmdir /S /Q curlbuild


REM ...and release build

robocopy curl-7.85.0 curlbuild /E /NFL /NDL /NJH /NJS /NP
cd curlbuild

cmake -G "Visual Studio 16 2019" -A x64 %FLAGS% -DMBEDTLS_INCLUDE_DIRS=..\mbedtls-3.2.1\include -DMBEDTLS_LIBRARY=..\build\mbedtls\windows-release\mbedtls.lib -DMBEDX509_LIBRARY=..\build\mbedtls\windows-release\mbedx509.lib -DMBEDCRYPTO_LIBRARY=..\build\mbedtls\windows-release\mbedcrypto.lib .
cd lib
msbuild /maxcpucount /p:Configuration=Release libcurl.vcxproj

cd ..\..

copy curlbuild\lib\Release\libcurl.lib build\curl\windows-release\curl.lib

rmdir /S /Q curlbuild
