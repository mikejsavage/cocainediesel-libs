#! /bin/sh

. ./common_macos.sh

flags="\
-DSDL_SHARED=OFF \
-DSDL_STATIC=ON \
-DSDL_TEST_LIBRARY=OFF

-DSDL_AUDIO=ON \
-DSDL_VIDEO=ON \
-DSDL_GPU=OFF \
-DSDL_RENDER=OFF \
-DSDL_CAMERA=OFF \
-DSDL_JOYSTICK=ON \
-DSDL_HAPTIC=OFF \
-DSDL_HIDAPI=OFF \
-DSDL_POWER=OFF \
-DSDL_SENSOR=OFF \
-DSDL_DIALOG=OFF \

-DSDL_DUMMYVIDEO=OFF \
-DSDL_OFFSCREEN=OFF \
-DSDL_OPENGL=OFF \
-DSDL_METAL=ON \

-DSDL_DISKAUDIO=OFF"

standard_cmake sdl SDL-3.2.4 "*.a" "$flags"
