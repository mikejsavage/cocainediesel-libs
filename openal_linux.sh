#! /bin/sh

. ./common_linux.sh

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
standard_cmake openal openal-soft-1.23.1 libopenal.a "$flags"

cp openal-soft-1.23.1/include/AL/*.h build/openal

rm -r openalbuild
