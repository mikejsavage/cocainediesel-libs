#! /bin/sh

mkdir -p build/linux-debug
mkdir -p build/linux-release

flags=
flags+=" --enable-static"
flags+=" --disable-shared"
flags+=" --disable-haptic"
flags+=" --disable-diskaudio"
flags+=" --disable-dummyaudio"
flags+=" --disable-video-dummy"
flags+=" --disable-video-opengles"
flags+=" --disable-video-vulkan"
flags+=" --disable-dbus"
flags+=" --disable-input-tslib"

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
