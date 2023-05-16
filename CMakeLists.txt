#
# @file     CMakeLists.txt
# @brief    Root CMakeFile for ATXMega256a3u and atmel328p in VSCode and CLion
# @author   Nico Verduin
# @date     14-4-2023
#

cmake_minimum_required(VERSION 3.20)

# get our avr toolchain location
include(file_locations.cmake)

#check if we can find the compilers
include(CMakeVerifyCompiler.cmake)

# give the project the root folder name
cmake_path(GET CMAKE_CURRENT_SOURCE_DIR FILENAME PROJECT_NAME)
string(REPLACE " " "_" ProjectId ${PROJECT_NAME})
project(${PROJECT_NAME} NONE)

# add our sub projects
include (projects_active.cmake)
