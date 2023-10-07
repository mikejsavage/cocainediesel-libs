#! /bin/sh

set -e

mkdir -p build/openal/linux-debug
mkdir -p build/openal/linux-release

flags="\
-DLIBTYPE=STATIC \
-DALSOFT_REQUIRE_SSE4_1=ON \
-DALSOFT_REQUIRE_ALSA=ON \
-DALSOFT_REQUIRE_PULSEAUDIO=ON \
-DALSOFT_UTILS=OFF \
-DALSOFT_EXAMPLES=OFF \
-DALSOFT_NO_CONFIG_UTIL=ON"

cp -r openal-soft-1.21.1 openalbuild
cd openalbuild
cmake -DCMAKE_BUILD_TYPE=Debug $flags .
make -j$(nproc --all)
cd ..

cp openalbuild/libopenal.a build/openal/linux-debug

rm -r openalbuild

cp -r openal-soft-1.21.1 openalbuild
cd openalbuild
cmake -DCMAKE_BUILD_TYPE=Release $flags .
make -j$(nproc --all)
cd ..

cp openalbuild/libopenal.a build/openal/linux-release

rm -r openalbuild

cp openal-soft-1.21.1/include/AL/*.h build/openal
