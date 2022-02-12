#! /bin/sh

set -e

mkdir -p build/yoga/linux-debug
mkdir -p build/yoga/linux-release

cp -r yoga-1.19.0 yogabuild
cd yogabuild

mkdir debug
cd debug
cmake -DCMAKE_BUILD_TYPE=Debug ..
make -j$(nproc --all)
cd ..

mkdir release
cd release
cmake -DCMAKE_BUILD_TYPE=Release ..
make -j$(nproc --all)
cd ..

cd ..

cp yogabuild/debug/libyoga.a build/yoga/linux-debug
cp yogabuild/release/libyoga.a build/yoga/linux-release

rm -r yogabuild

cp yoga-1.19.0/yoga/*.h build/yoga
