#! /bin/sh

set -e

mkdir -p build/yoga/linux-debug
mkdir -p build/yoga/linux-release

cp -r yoga-2.0.1 yogabuild
cd yogabuild

cmake -Bdebugbuild
cmake --build debugbuild --target yogacore --config Debug --parallel $(nproc --all)
cmake -Breleasebuild
cmake --build releasebuild --target yogacore --config Release --parallel $(nproc --all)

cd ..

cp yogabuild/debugbuild/yoga/libyogacore.a build/yoga/linux-debug
cp yogabuild/releasebuild/yoga/libyogacore.a build/yoga/linux-release

rm -r yogabuild

cp yoga-2.0.1/yoga/*.h build/yoga
