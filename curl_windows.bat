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
set FLAGS=%FLAGS% -DCURL_USE_SCHANNEL=ON
set FLAGS=%FLAGS% -DCURL_WINDOWS_SSPI=OFF

robocopy curl-8.5.0 curlbuild /E /NFL /NDL /NJH /NJS /NP
cd curlbuild

cmake -G "Visual Studio 17 2022" -A x64 %FLAGS% .
msbuild /maxcpucount ALL_BUILD.vcxproj
msbuild /maxcpucount /p:Configuration=Release ALL_BUILD.vcxproj

cd ..

copy curlbuild\lib\Debug\libcurl-d.lib build\curl\windows-debug\curl.lib
copy curlbuild\lib\libcurl_object.dir\Debug\libcurl_object.pdb build\curl\windows-debug
copy curlbuild\lib\Release\libcurl.lib build\curl\windows-release\curl.lib

rmdir /S /Q curlbuild
