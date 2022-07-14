# We wrote this, don't overwrite it please lol

cmake_minimum_required(VERSION 3.15)
cmake_policy(SET CMP0091 NEW)
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")

project(discord LANGUAGES CXX)
add_library(discord STATIC)
target_compile_features(discord PUBLIC cxx_std_17)
target_include_directories(discord PUBLIC .)

if (WIN32)
	set(OS_SRCS connection_win.cpp discord_register_win.cpp)
else()
	set(OS_SRCS connection_unix.cpp discord_register_linux.cpp)
endif()

target_sources(discord PRIVATE discord_rpc.cpp rpc_connection.cpp serialization.cpp ${OS_SRCS})
