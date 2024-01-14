#! /bin/sh

set -e

mkdir -p build/tracy/macos-debug
mkdir -p build/tracy/macos-release

# capstone
cp -r capstone-4.0.2 capstonebuild
cd capstonebuild

capstone_flags="\
-DCAPSTONE_BUILD_SHARED=OFF \
-DCAPSTONE_BUILD_DIET=ON \
-DCAPSTONE_BUILD_TESTS=OFF \
-DCAPSTONE_BUILD_CSTOOL=OFF \
-DCAPSTONE_X86_ATT_DISABLE=ON \
-DCAPSTONE_ARCHITECTURE_DEFAULT=OFF \
-DCAPSTONE_ARM64_SUPPORT=ON \
-DCAPSTONE_X86_SUPPORT=ON"

cmake -Bbuild -GXcode -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" -DCMAKE_OSX_DEPLOYMENT_TARGET=10.15 $capstone_flags .
cmake --build build --config Release

cd ..

# tracy
tracy_gui_cflags="\
-I../../../../capstone-4.0.2/include/capstone \
-I../../../../glfw-3.3.8/include \
-I../../../../freetype-2.13.2/include"
tracy_gui_ldflags="\
../../../../capstonebuild/build/Release/libcapstone.a \
../../../../build/glfw3/macos-release/libglfw3.a -framework IOKit \
../../../../build/freetype/macos-release/libfreetype.a"
null_pkg_config="$(pwd)/null-pkg-config:$PATH"

tracy_client_flags="-c -std=c++11 -mmacosx-version-min=10.15"

cp -r tracy-0.9.1 tracybuild
cd tracybuild

# gui
cd profiler/build/unix

PATH="$null_pkg_config" make CFLAGS="$tracy_gui_cflags -arch arm64" LDFLAGS="$tracy_gui_ldflags" release
mv Tracy-release Tracy-arm64

rm -r obj

PATH="$null_pkg_config" make CFLAGS="$tracy_gui_cflags -arch x86_64" LDFLAGS="$tracy_gui_ldflags" release
mv Tracy-release Tracy-x64

lipo Tracy-arm64 Tracy-x64 -create -output Tracy
strip Tracy

cd ../../..

# lib
cd public

clang++ TracyClient.cpp $tracy_client_flags -arch arm64 -O2 -DTRACY_ENABLE -o tracy-arm64-debug.o
clang++ TracyClient.cpp $tracy_client_flags -arch x86_64 -O2 -DTRACY_ENABLE -o tracy-x64-debug.o
ar r libtracy-arm64-debug.a tracy-arm64-debug.o
ar r libtracy-x64-debug.a tracy-x64-debug.o
lipo libtracy-arm64-debug.a libtracy-x64-debug.a -create -output libtracy-debug.a

clang++ TracyClient.cpp $tracy_client_flags -arch arm64 -O2 -o tracy-arm64-release.o
clang++ TracyClient.cpp $tracy_client_flags -arch x86_64 -O2 -o tracy-x64-release.o
ar r libtracy-arm64-release.a tracy-arm64-release.o
ar r libtracy-x64-release.a tracy-x64-release.o
lipo libtracy-arm64-release.a libtracy-x64-release.a -create -output libtracy-release.a

cd ..

cd ..

cp tracybuild/profiler/build/unix/Tracy build/tracy/Tracy.macos
cp tracybuild/public/libtracy-debug.a build/tracy/macos-debug/libtracy.a
cp tracybuild/public/libtracy-release.a build/tracy/macos-release/libtracy.a

rm -rf capstonebuild tracybuild
