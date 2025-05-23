set -e

zig-cmake/download_zig.sh

export CMAKE_TOOLCHAIN_FILE="$(pwd)/zig-cmake/zig.cmake"

standard_cmake() {
	mkdir -p "build/$1/linux-debug"
	mkdir -p "build/$1/linux-release"

	cp -r "$2" "$1build"
	cd "$1build"

	$EXTRA_PREBUILD_COMMANDS

	cmake -G "Ninja Multi-Config" -Bbuild $4
	cmake --build build $EXTRA_BUILD_ARGS --config Debug --parallel $(nproc --all)
	cmake --build build $EXTRA_BUILD_ARGS --config Release --parallel $(nproc --all)

	cd ..

	cp "$1build/build/$(dirname "$3")/Debug/"$(basename "$3") "build/$1/linux-debug"
	cp "$1build/build/$(dirname "$3")/Release/"$(basename "$3") "build/$1/linux-release"
}
