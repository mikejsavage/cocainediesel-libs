#! /bin/sh

set -e

mkdir -p build/glfw3/macos-debug
mkdir -p build/glfw3/macos-release

export MACOSX_DEPLOYMENT_TARGET="10.13"
flags="-DGLFW_BUILD_EXAMPLES=OFF -DGLFW_BUILD_TESTS=OFF -DGLFW_BUILD_DOCS=OFF"

cp -r glfw-3.3.8 glfwbuild
cd glfwbuild

cmake -Bbuild -GXcode -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" $flags
cmake --build build --config Debug
cmake --build build --config Release

cd ..

cp glfwbuild/build/src/Debug/libglfw3.a build/glfw3/macos-debug
cp glfwbuild/build/src/Release/libglfw3.a build/glfw3/macos-debug

rm -r glfwbuild
