#! /bin/sh

mkdir -p build/linux-debug
mkdir -p build/linux-release

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

cp sdlbuild/build/.libs/libSDL2.a build/linux-debug
cp sdlbuild/build/.libs/libSDL2main.a build/linux-debug

cp sdlbuild/build/.libs/libSDL2.a build/linux-release
cp sdlbuild/build/.libs/libSDL2main.a build/linux-release

rm -r sdlbuild
