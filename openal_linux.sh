#! /bin/sh

set -e

mkdir -p build/openal/linux-debug
mkdir -p build/openal/linux-release

flags="\
-DLIBTYPE=STATIC \
-DALSOFT_REQUIRE_SSE4_1=ON \
-DALSOFT_BACKEND_PIPEWIRE=OFF \
-DALSOFT_BACKEND_PULSEAUDIO=OFF \
-DALSOFT_BACKEND_ALSA=OFF \
-DALSOFT_BACKEND_OSS=OFF \
-DALSOFT_BACKEND_JACK=OFF \
-DALSOFT_BACKEND_PORTAUDIO=OFF \
-DALSOFT_BACKEND_WAVE=OFF \
-DALSOFT_UTILS=OFF \
-DALSOFT_EXAMPLES=OFF \
-DALSOFT_NO_CONFIG_UTIL=ON \
-DALSOFT_INSTALL_AMBDEC_PRESETS=OFF"

cp -r openal-soft-1.23.1 openalbuild
cd openalbuild

cmake -Bdebugbuild $flags
cmake --build debugbuild --config Debug --parallel $(nproc --all)
cmake -Breleasebuild $flags
cmake --build releasebuild --config Release --parallel $(nproc --all)

cd ..

cp openalbuild/debugbuild/libopenal.a build/openal/linux-debug
cp openalbuild/releasebuild/libopenal.a build/openal/linux-release

rm -r openalbuild

cp openal-soft-1.23.1/include/AL/*.h build/openal
