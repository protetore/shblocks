#!/bin/bash
#
# Useful functions to handle arrays
#
# Protetore Shell Util Package
# github.com.protetore/shblocks.git
#


# Check if a value exists in an array
# @param $1 mixed  Needle
# @param $2 array  Haystack
# @return  Success (0) if value exists, Failure (1) otherwise
array::in_array() {
    local hay needle=$1
    shift
    for hay; do
        [[ $hay == "$needle" ]] && return 0
    done
    return 1
}
