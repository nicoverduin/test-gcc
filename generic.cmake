    #
    # @file     generic.cmake
    # @brief    Generic CMakeFile for gcc (desktop applications) in VSCode
    #           Needs to be imported into the root of the individual
    #           sub projects
    # @author   Nico Verduin
    # version   1.0  original
    # @date     16-5-2023
    #

    # no need to check compilers
    set(CMAKE_C_COMPILER_WORKS 1)
    set(CMAKE_CXX_COMPILER_WORKS 1)

    # Make sure compile_commands.json is generated
    # (which is used by clangd for autocompletion and such)
    set(CMAKE_EXPORT_COMPILE_COMMANDS ON)

    # macro to get all the subdirectories from the current path
    # that contain source files
    #see also https://stackoverflow.com/questions/17653738/recursive-cmake-search-for-header-and-source-files
    MACRO(subdirlist  return_list)
        # get all files in all subdirs and put into new_list
        # filter on C source and header files
        #           C++ source and header files
        #           Assembly source and header files files
        FILE(GLOB_RECURSE  new_list  *.c *.h *.cpp *.hpp *.s *.inc)

        # create an empty list
        SET(dir_list "")

        # get the path + filename and put in into dir_path
        FOREACH(file_path ${new_list})
            # strip the file name
            GET_FILENAME_COMPONENT(dir_path ${file_path} PATH)

            # extend our pahtname list
            SET(dir_list ${dir_list} ${dir_path})
        ENDFOREACH()

        #remove any duplicate folders
        LIST(REMOVE_DUPLICATES dir_list)

        #return a clean list
        SET(${return_list} ${dir_list})
    ENDMACRO()

    # give the project the root folder name
    cmake_path(GET CMAKE_CURRENT_SOURCE_DIR FILENAME PROJECT_NAME)

    # get the name of our subproject
    string(REPLACE " " "_" ProjectId ${PROJECT_NAME})

    # Now the project is reset to the latest state
    project(${PROJECT_NAME} C CXX NONE)

    # if you want to program in C++ or assembly that option is also added
    # just the standard folders in the root
    set(PROJECT_SOURCE_DIR RECURSE "*.c" "*.h" "*.cpp" "*.hpp" "*.s" )

    # add search directories under the subproject directory itself
    # by scanning any directory with the select filetypes and
    # then in the macro remove the filenames and doubles
    include_directories(${CMAKE_CURRENT_SOURCE_DIR})
    SUBDIRLIST(SUBDIRS ${PROJECT_SOURCE_DIR})
    FOREACH(subdir ${SUBDIRS})
        include_directories(${subdir})
    ENDFOREACH()

    # get all the sources. including those from sub directories
    file(GLOB_RECURSE PROJECT_SRC CONFIGURE_DEPENDS ${PROJECT_SOURCE_DIR})

    # create our executable file
    message (STATUS projectname=${PROJECT_NAME})

    add_executable(${PROJECT_NAME}
            ${PROJECT_SRC}
    )

