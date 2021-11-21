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
set FLAGS=%FLAGS% -DCMAKE_USE_SCHANNEL=ON
set FLAGS=%FLAGS% -DCURL_WINDOWS_SSPI=OFF

robocopy curl-7.80.0 curlbuild /E /NFL /NDL /NJH /NJS /NP
cd curlbuild

cmake -G "Visual Studio 16 2019" -A x64 %FLAGS% .
cd lib
msbuild /maxcpucount libcurl.vcxproj
msbuild /maxcpucount /p:Configuration=Release libcurl.vcxproj

cd ..\..

copy curlbuild\lib\Debug\libcurl-d.lib build\curl\windows-debug\curl.lib
copy curlbuild\lib\Debug\libcurl.pdb build\curl\windows-debug
copy curlbuild\lib\Release\libcurl.lib build\curl\windows-release\curl.lib

REM rmdir /S /Q curlbuild
