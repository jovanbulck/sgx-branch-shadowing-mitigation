# Author: Hans Liljestrand, Shohreh Hosseinzadeh
# Copyright: Secure Systems Group, Aalto University https://ssg.aalto.fi/
# This code is released under Apache 2.0 license

###############################################################################
# Source
# https://github.com/gnzlbg/hm3/blob/master/cmake/Findspdlog.cmake
###############################################################################
# Licensed:
# Copyright 2013-2015 Gonzalo Brito Gadeschi
#
# Boost Software License - Version 1.0 - August 17th, 2003
#
# Permission is hereby granted, free of charge, to any person or organization obtaining a copy of the software and accompanying documentation covered by this license (the "Software") to use, reproduce, display, distribute, execute, and transmit the Software, and to prepare derivative works of the Software, and to permit third-parties to whom the Software is furnished to do so, all subject to the following:
#
# The copyright notices in the Software and this entire statement, including the above license grant, this restriction and the following disclaimer, must be included in all copies of the Software, in whole or in part, and all derivative works of the Software, unless such copies or derivative works are solely in the form of machine-executable object code generated by a source language processor.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
###############################################################################
#
# Find the spdlog include directory
# The following variables are set if spdlog is found.
#  spdlog_FOUND        - True when the spdlog include directory is found.
#  spdlog_INCLUDE_DIR  - The path to where the spdlog include files are.
# If spdlog is not found, spdlog_FOUND is set to false.

find_package(PkgConfig)

if(NOT EXISTS "${spdlog_INCLUDE_DIR}")
    find_path(spdlog_INCLUDE_DIR
            PATHS /usr/include
            NAMES spdlog/spdlog.h
            DOC "spdlog library header files"
            )
endif()

if(EXISTS "${spdlog_INCLUDE_DIR}")
    message(STATUS, "IIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII")
    include(FindPackageHandleStandardArgs)
    mark_as_advanced(spdlog_INCLUDE_DIR)
else()
    message(STATUS, "HHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHHH")
    include(ExternalProject)
    ExternalProject_Add(spdlog
            GIT_REPOSITORY https://github.com/gabime/spdlog.git
            TIMEOUT 5
            CMAKE_ARGS -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER} -DCMAKE_CXX_FLAGS=${CMAKE_CXX_FLAGS}
            PREFIX "${CMAKE_CURRENT_BINARY_DIR}"
            CONFIGURE_COMMAND "" # Disable configure step
            BUILD_COMMAND "" # Disable build step
            INSTALL_COMMAND "" # Disable install step
            UPDATE_COMMAND "" # Disable update step: clones the project only once
            )

    # Specify include dir
    ExternalProject_Get_Property(spdlog source_dir)
    set(spdlog_INCLUDE_DIR ${source_dir}/include)
endif()

if(EXISTS "${spdlog_INCLUDE_DIR}")
    set(spdlog_FOUND 1)
else()
    set(spdlog_FOUND 0)
endif()