set -e

standard_cmake() {
	mkdir -p "build/$1/macos-debug"
	mkdir -p "build/$1/macos-release"

	cp -r "$2" "$1build"
	cd "$1build"

	cmake -GXcode -Bbuild -DCMAKE_OSX_ARCHITECTURES="arm64;x86_64" -DCMAKE_OSX_DEPLOYMENT_TARGET=10.15 $4
	cmake --build build $5 --config Debug --parallel $(nproc --all)
	cmake --build build $5 --config Release --parallel $(nproc --all)

	cd ..

	cp "$1build/build/$(dirname "$3")/Debug/"$(basename "$3") "build/$1/macos-debug"
	cp "$1build/build/$(dirname "$3")/Release/"$(basename "$3") "build/$1/macos-release"

	rm -rf "$1build"
}
