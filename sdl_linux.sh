#! /bin/sh

. ./common_linux.sh

# cmake autodetection should set SDL_VIDEO_OPENGL=ON/SDL_VIDEO_OPENGL_GLX=ON
# but cmake is a shithole build system so it doesn't and we have to do it
# manually here
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
-DSDL_OPENGL=ON \
-DSDL_OPENGLES=OFF \
-DSDL_VULKAN=OFF \
-DSDL_X11=ON \
-DSDL_WAYLAND=ON \
-DSDL_VIDEO_OPENGL=ON \
-DSDL_VIDEO_OPENGL_GLX=ON \

-DSDL_DUMMYAUDIO=OFF \
-DSDL_DISKAUDIO=OFF \
-DSDL_ALSA=ON \
-DSDL_JACK=OFF \
-DSDL_PULSEAUDIO=ON \
-DSDL_PIPEWIRE=ON"

EXTRA_PREBUILD_COMMANDS="patch -p1 -i ../sdl_linux.patch"
standard_cmake sdl SDL-3.2.4 "*.a" "$flags"

cp -r SDL-3.2.4/include/SDL3 build/sdl

rm -r sdlbuild
