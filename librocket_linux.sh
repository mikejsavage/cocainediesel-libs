#! /bin/sh

set -e

mkdir -p build/librocket/linux-debug
mkdir -p build/librocket/linux-release

flags="
-DBUILD_SHARED_LIBS=OFF
-DCMAKE_CXX_FLAGS=-fPIC"

cp -r libRocket librocketbuild
cd librocketbuild/Build
cmake -DCMAKE_BUILD_TYPE=Debug $flags .
make -j$(nproc --all) RocketCore RocketControls
cd ../..

cp librocketbuild/Build/libRocketCore.a build/librocket/linux-debug
cp librocketbuild/Build/libRocketControls.a build/librocket/linux-debug

rm -r librocketbuild

cp -r libRocket librocketbuild
cd librocketbuild/Build
cmake -DCMAKE_BUILD_TYPE=Release $flags .
make -j$(nproc --all) RocketCore RocketControls
cd ../..

cp librocketbuild/Build/libRocketCore.a build/librocket/linux-release
cp librocketbuild/Build/libRocketControls.a build/librocket/linux-release

rm -r librocketbuild

cp -r libRocket/Include/Rocket build/librocket
rm -r build/librocket/Include/Debugger build/librocket/Include/Debugger.h
