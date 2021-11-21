#! /bin/sh

set -e

mkdir -p build/glfw3/linux-debug
mkdir -p build/glfw3/linux-release

flags="\
-DGLFW_BUILD_EXAMPLES=OFF \
-DGLFW_BUILD_TESTS=OFF \
-DGLFW_BUILD_DOCS=OFF"

cp -r glfw-3.3.5 glfwbuild
cd glfwbuild

mkdir debugbuild
cd debugbuild
cmake -DCMAKE_BUILD_TYPE=Debug $flags ..
make -j$(nproc --all)
cd ..

mkdir releasebuild
cd releasebuild
cmake -DCMAKE_BUILD_TYPE=Release $flags ..
make -j$(nproc --all)
cd ..

cd ..

cp glfwbuild/debugbuild/src/libglfw3.a build/glfw3/linux-debug
cp glfwbuild/releasebuild/src/libglfw3.a build/glfw3/linux-release

cp -r glfw-3.3.5/include/* build/glfw3

rm -r glfwbuild
