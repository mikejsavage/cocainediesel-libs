set -e

zig-cmake/download_zig.sh

export CMAKE_TOOLCHAIN_FILE="$(pwd)/zig-cmake/zig.cmake"

standard_cmake() {
	mkdir -p "build/$1/linux-debug"
	mkdir -p "build/$1/linux-release"

	cp -r "$2" "$1build"
	cd "$1build"

	cmake -Bdebugbuild $4
	cmake --build debugbuild $5 --config Debug --parallel $(nproc --all)
	cmake -Breleasebuild $4
	cmake --build releasebuild $5 --config Release --parallel $(nproc --all)

	cd ..

	cp "$1build/debugbuild/"$3 "build/$1/linux-debug"
	cp "$1build/releasebuild/"$3 "build/$1/linux-release"
}
