FROM docker.io/alpine

RUN apk update
RUN apk upgrade
RUN apk add bash make cmake ninja patch
RUN apk add libxcursor-dev libxi-dev libxrandr-dev libxinerama-dev libxkbcommon-dev
RUN apk add wayland-dev wayland-protocols
RUN apk add mesa-dev
RUN apk add alsa-lib-dev pulseaudio-dev pipewire-dev

COPY . /cocainediesel-libs
WORKDIR /cocainediesel-libs

RUN ./curl_linux.sh
RUN ./discord_linux.sh
RUN ./freetype_linux.sh
RUN ./glad_linux.sh
RUN ./luau_linux.sh
RUN ./openal_linux.sh
RUN ./sdl_linux.sh
RUN ./zstd_linux.sh
