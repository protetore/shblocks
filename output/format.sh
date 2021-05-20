#!/usr/bin/env bash
#
# Useful functions to format output
#
# Protetore Shell Util Package
# github.com.protetore/shblocks.git
#

# Pad a string to the left to a given size with spaces
# @param $1 string the string to be padded
# @param $2 integer the maximum size
format::paddingLeft() {
    value=$1
    colSize=$2
    valueSize=${#value}
    padSize=$((colSize - valueSize))
    printf -v padding "%${padSize}s"
    echo -e "${padding}${value}"
}

# Pad a string to the right to a given size with spaces
# @param $1 string the string to be padded
# @param $2 integer the maximum size
format::paddingRight() {
    value=$1
    colSize=$2
    valueSize=${#value}
    padSize=$((colSize - valueSize))
    printf -v padding "%${padSize}s"
    echo -e "${value}${padding}"
}

# Pad a string to the center to a given size with spaces
# @param $1 string the string to be padded
# @param $2 integer the maximum size
format::paddingCenter() {
    value=$1
    colSize=$2
    valueSize=${#value}
    padSize=$(((colSize - valueSize) / 2))
    adjustSize=$((valueSize-(padSize*2)))
    printf -v padding "%${padSize}s"
    printf -v adjust "%${adjustSize}s"
    echo -e "${padding}${value}${padding}${adjust}"
}
