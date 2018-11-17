#! /bin/sh

mkdir -p build/openal/linux-debug
mkdir -p build/openal/linux-release

flags="\
-DLIBTYPE=STATIC \
-DALSOFT_UTILS=OFF \
-DALSOFT_EXAMPLES=OFF \
-DALSOFT_TESTS=OFF
-DALSOFT_AMBDEC_PRESETS=OFF"

cp -r openal-soft-openal-soft-1.19.1 openalbuild
cd openalbuild
cmake -DCMAKE_BUILD_TYPE=Debug $flags .
make -j$(nproc --all)
cd ..

cp openalbuild/libopenal.a build/openal/linux-debug

rm -r openalbuild

cp -r openal-soft-openal-soft-1.19.1 openalbuild
cd openalbuild
cmake -DCMAKE_BUILD_TYPE=Release $flags .
make -j$(nproc --all)
cd ..

cp openalbuild/libopenal.a build/openal/linux-release

rm -r openalbuild

cp openal-soft-openal-soft-1.19.1/include/AL/*.h build/openal
