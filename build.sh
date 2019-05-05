#!/bin/bash
# Script to build all components from scratch, using the maximum available CPU power
#
# Given parameters are passed over to CMake.
# Examples:
#    * ./build_all.sh -DCMAKE_BUILD_TYPE=Debug
#    * ./build_all.sh VERBOSE=1
#
# Written by Tiffany Huang, 12/14/2016
#

# Go into the directory where this bash script is contained.
cd `dirname $0`

# Compile code.
rm -rf build
mkdir -p build
cd build
CC=/usr/bin/gcc CXX=/usr/bin/g++  cmake ..
make $*
