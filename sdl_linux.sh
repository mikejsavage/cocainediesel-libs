#! /bin/sh

set -e

mkdir -p build/sdl/linux-debug
mkdir -p build/sdl/linux-release

flags="\
--enable-static \
--disable-shared \
--disable-haptic \
--disable-diskaudio \
--disable-dummyaudio \
--disable-video-dummy \
--disable-video-opengles \
--disable-video-vulkan \
--disable-dbus \
--disable-input-tslib"

cp -r SDL2-2.0.9 sdlbuild
cd sdlbuild
./configure $flags
make -j$(nproc --all)
cd ..

cp sdlbuild/build/.libs/libSDL2.a build/sdl/linux-debug
cp sdlbuild/build/.libs/libSDL2.a build/sdl/linux-release

rm -r sdlbuild

cp SDL2-2.0.9/include/*.h build/sdl
