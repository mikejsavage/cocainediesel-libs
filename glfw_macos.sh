#! /bin/sh

set -e

mkdir -p build/glfw3/macos-debug
mkdir -p build/glfw3/macos-release

flags="-DGLFW_BUILD_EXAMPLES=OFF -DGLFW_BUILD_TESTS=OFF -DGLFW_BUILD_DOCS=OFF"

cp -r glfw-3.4 glfwbuild
cd glfwbuild

cmake -Bbuild -GXcode -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" -DCMAKE_OSX_DEPLOYMENT_TARGET=10.15 $flags
cmake --build build --config Debug
cmake --build build --config Release

cd ..

cp glfwbuild/build/src/Debug/libglfw3.a build/glfw3/macos-debug
cp glfwbuild/build/src/Release/libglfw3.a build/glfw3/macos-release

rm -rf glfwbuild
