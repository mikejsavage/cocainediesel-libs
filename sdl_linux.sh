#! /bin/sh

set -e

mkdir -p build/sdl/linux-debug
mkdir -p build/sdl/linux-release

flags="\
--enable-static \
--disable-shared \
--disable-haptic \
--disable-joystick \
--disable-audio \
--disable-sensor \
--disable-video-dummy \
--disable-video-opengles \
--disable-video-vulkan \
--disable-dbus \
--disable-libsamplerate \
--disable-input-tslib"

cp -r SDL2-2.0.9 sdlbuild
cd sdlbuild
./configure $flags
make -j$(nproc --all)
cd ..

cp sdlbuild/build/.libs/libSDL2.a build/sdl/linux-debug/libsdl.a
cp sdlbuild/build/.libs/libSDL2.a build/sdl/linux-release/libsdl.a

cp sdlbuild/include/SDL_config.h build/sdl/SDL_config_linux.h

rm -r sdlbuild

cp SDL2-2.0.9/include/*.h build/sdl
