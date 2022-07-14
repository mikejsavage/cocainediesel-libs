mkdir build
mkdir build\discord
mkdir build\discord\windows-debug
mkdir build\discord\windows-release

robocopy discord-rpc discordbuild /E /NFL /NDL /NJH /NJS /NP
cd discordbuild

cmake -G "Visual Studio 16 2019" -A x64 .
msbuild /maxcpucount discord.vcxproj
msbuild /maxcpucount /p:Configuration=Release discord.vcxproj

cd ..

copy discord\Debug\discord.lib build\discord\windows-debug
copy discord\Debug\discord.pdb build\discord\windows-debug
copy discord\Release\discord.lib build\discord\windows-release

rmdir /S /Q discordbuild
