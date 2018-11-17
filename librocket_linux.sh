#! /bin/sh

set -e
set -x

mkdir -p build/librocket/linux-debug
mkdir -p build/librocket/linux-release

cp -r libRocket librocketbuild
cd librocketbuild

srcs="Source/Core/*.cpp Source/Controls/*.cpp"
objs="Source/Core/*.o Source/Controls/*.o"

CXXFLAGS="-std=c++11 -IInclude -DROCKET_STATIC_LIB"
DEBUGCXXFLAGS="$CXXFLAGS -g"
RELEASECXXFLAGS="$CXXFLAGS -O2"

for f in $srcs; do
	g++ -c $DEBUGCXXFLAGS -o "$f.o" "$f"
done

ar rs librocketdebug.a $objs

rm $objs

for f in $srcs; do
	g++ -c $RELEASECXXFLAGS -o "$f.o" "$f"
done

ar rs librocket.a $objs

cd ..

cp librocketbuild/librocketdebug.a build/librocket/linux-debug/librocket.a
cp librocketbuild/librocket.a build/librocket/linux-release/librocket.a

rm -r librocketbuild

cp -r libRocket/Include/* build/librocket
