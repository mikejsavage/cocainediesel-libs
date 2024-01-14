FROM docker.io/alpine
COPY . /cocainediesel-libs
WORKDIR /cocainediesel-libs

RUN apk update
RUN apk upgrade
RUN apk add bash make cmake
RUN apk add libxcursor-dev libxi-dev libxrandr-dev libxinerama-dev libxkbcommon-dev
RUN apk add wayland-dev wayland-protocols

RUN ./curl_linux.sh
RUN ./discord_linux.sh
RUN ./freetype_linux.sh
RUN ./glad_linux.sh
RUN ./glfw_linux.sh
RUN ./luau_linux.sh
RUN ./openal_linux.sh
RUN ./yoga_linux.sh
RUN ./zstd_linux.sh
