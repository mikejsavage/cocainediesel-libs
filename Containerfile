FROM docker.io/alpine

RUN apk update
RUN apk upgrade
RUN apk add bash make cmake ninja
RUN apk add patch # sdl
RUN apk add libxcursor-dev libxi-dev libxrandr-dev libxinerama-dev libxkbcommon-dev # sdl video
RUN apk add wayland-dev wayland-protocols # sdl video
RUN apk add mesa-dev # sdl video
RUN apk add alsa-lib-dev pulseaudio-dev pipewire-dev # sdl audio

COPY . /cocainediesel-libs
WORKDIR /cocainediesel-libs

RUN ./curl_linux.sh
RUN ./discord_linux.sh
RUN ./freetype_linux.sh
RUN ./glad_linux.sh
RUN ./luau_linux.sh
RUN ./openal_linux.sh
RUN ./sdl_linux.sh
RUN ./tracy_linux.sh
RUN ./zstd_linux.sh
