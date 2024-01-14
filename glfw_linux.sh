#! /bin/sh

set -e

mkdir -p build/glfw3/linux-debug
mkdir -p build/glfw3/linux-release

flags="\
-DGLFW_BUILD_X11=ON \
-DGLFW_BUILD_WAYLAND=ON \
-DGLFW_BUILD_EXAMPLES=OFF \
-DGLFW_BUILD_TESTS=OFF \
-DGLFW_BUILD_DOCS=OFF"

cp -r glfw-3.4-g57cbded0 glfwbuild
cd glfwbuild

cmake -Bdebugbuild $flags
cmake --build debugbuild --config Debug --parallel $(nproc --all)
cmake -Breleasebuild $flags
cmake --build releasebuild --config Release --parallel $(nproc --all)

cd ..

cp glfwbuild/debugbuild/src/libglfw3.a build/glfw3/linux-debug
cp glfwbuild/releasebuild/src/libglfw3.a build/glfw3/linux-release

cp -r glfw-3.4-g57cbded0/include/* build/glfw3

rm -r glfwbuild
