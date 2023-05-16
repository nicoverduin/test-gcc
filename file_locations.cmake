#
# @file     file_locations.cmake
# @brief    This cmake file contains all the roots to our compiler and avrdude
# @author   Nico Verduin
# version   1.0 original
# @date     11-5-2023
#

# root folder of our tool. is automatically determined
cmake_path(GET CMAKE_CURRENT_SOURCE_DIR PARENT_PATH DEV_ROOT)

# depending on the platform used the compiler folder might need to be changed or left blank
if(${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Windows")
    # windows avr-gcc compiler
    set(TOOLCHAIN_PATH "C:/msys64/mingw64/bin")
else()
    if(${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Darwin")
        # mac osx avr-gcc compiler. Using standard packager installation
    #    set(TOOLCHAIN_PATH "${DEV_ROOT}/avr8-gnu-toolchain-darwin_x86_64/bin")
    else()
        # linux avr-gcc compiler. Using standard packager installation
    #    set(TOOLCHAIN_PATH "${DEV_ROOT}/avr8-gnu-toolchain-linux_x86_64/bin")
    endif()
endif()

# do we need file extensions?
if(${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Darwin" OR ${CMAKE_HOST_SYSTEM_NAME} STREQUAL "Linux")
    # OSX no file extension
    set(FILE_EXTENSION "")
else()
    # Windows with file extension
    set(FILE_EXTENSION ".exe")
endif()

# our compilers
set (CMAKE_C_COMPILER   ${TOOLCHAIN_PATH}/gcc${FILE_EXTENSION} )
set (CMAKE_CXX_COMPILER ${TOOLCHAIN_PATH}/g++${FILE_EXTENSION})

# set path for the compiler
set(PATH ${TOOLCHAIN_PATH}../)

