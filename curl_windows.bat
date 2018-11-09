mkdir build
mkdir build\curl
mkdir build\curl\windows-debug
mkdir build\curl\windows-release

set FLAGS=%FLAGS% -DBUILD_CURL_EXE=OFF
set FLAGS=%FLAGS% -DBUILD_SHARED_LIBS=OFF
set FLAGS=%FLAGS% -DCURL_STATIC_CRT=ON
set FLAGS=%FLAGS% -DHTTP_ONLY=ON
set FLAGS=%FLAGS% -DCURL_ZLIB=OFF

robocopy curl-7.62.0 curlbuild /E /NFL /NDL /NJH /NJS /NP
cd curlbuild

cmake -G "Visual Studio 14 2015 Win64" %FLAGS% .
cd lib
msbuild /maxcpucount libcurl.vcxproj
msbuild /maxcpucount /p:Configuration=Release libcurl.vcxproj

cd ..\..

cp curlbuild\lib\Debug\libcurl-d.lib build\curl\windows-debug\curl.lib
cp curlbuild\lib\libcurl.dirDebug\libcurl.pdb build\curl\windows-debug\curl.pdb
cp curlbuild\lib\Release\libcurl.lib build\curl\windows-release\curl.lib

rmdir /S /Q curlbuild
