#! /bin/sh

set -e

podman build --ulimit=nofile=131072:1048576 .
image="$(podman images -n --format "{{ .Id }}" | head -1)"
podman create --name cocainediesel-libs "$image"
podman cp cocainediesel-libs:/cocainediesel-libs/build/ containerbuild
podman rm cocainediesel-libs
