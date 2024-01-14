# We wrote this, don't overwrite it please lol

cmake_minimum_required(VERSION 3.15)
cmake_policy(SET CMP0091 NEW)
set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")

project(yoga LANGUAGES CXX)
add_library(yoga STATIC)
target_compile_features(yoga PUBLIC cxx_std_17)
target_include_directories(yoga PUBLIC . yoga)

target_sources(yoga PRIVATE
	yoga/Utils.cpp
	yoga/YGConfig.cpp
	yoga/YGEnums.cpp
	yoga/YGLayout.cpp
	yoga/YGNode.cpp
	yoga/YGNodePrint.cpp
	yoga/YGStyle.cpp
	yoga/YGValue.cpp
	yoga/Yoga.cpp
	yoga/log.cpp
	yoga/event/event.cpp
)
