#! /bin/sh

. ./common_linux.sh

flags="\
-DGLFW_BUILD_X11=ON \
-DGLFW_BUILD_WAYLAND=ON \
-DGLFW_BUILD_EXAMPLES=OFF \
-DGLFW_BUILD_TESTS=OFF \
-DGLFW_BUILD_DOCS=OFF"
standard_cmake glfw3 glfw-3.4-g57cbded0 src/libglfw3.a "$flags"

cp -r glfw-3.4-g57cbded0/include/* build/glfw3

rm -r glfw3build
