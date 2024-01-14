#! /bin/sh

set -e

echo "113b562ccae72f737c3c6016c0129000b6031718b21d662d3032eef87f0264c6 yoga-2.0.1/CMakeLists.txt" | sha256sum -c

mkdir -p build/yoga/linux-debug
mkdir -p build/yoga/linux-release

cp -r yoga-2.0.1 yogabuild
cd yogabuild

cmake -Bdebugbuild
cmake --build debugbuild --config Debug --parallel $(nproc --all)
cmake -Breleasebuild
cmake --build releasebuild --config Release --parallel $(nproc --all)

cd ..

cp yogabuild/debugbuild/libyoga.a build/yoga/linux-debug
cp yogabuild/releasebuild/libyoga.a build/yoga/linux-release

rm -r yogabuild

cp yoga-2.0.1/yoga/*.h build/yoga
