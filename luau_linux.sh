#! /bin/sh

set -e

mkdir -p build/luau/linux-debug
mkdir -p build/luau/linux-release

cp -r luau-0.524 luaubuild
cd luaubuild

targets="Luau.Ast Luau.Compiler Luau.VM"

cmake -Bdebugbuild
cmake --build debugbuild --target $targets --config Debug --parallel $(nproc --all)
cmake -Breleasebuild
cmake --build releasebuild --target $targets --config Release --parallel $(nproc --all)

cd ..

cp luaubuild/debugbuild/*.a build/luau/linux-debug
cp luaubuild/releasebuild/*.a build/luau/linux-release

rm -r luaubuild

cp luau-0.524/Compiler/include/*.h build/luau
cp luau-0.524/VM/include/*.h build/luau
