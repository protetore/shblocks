#!/usr/bin/env bash
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
array::inArray() {
    local hay needle=$1
    shift
    for hay; do
        [[ $hay == "$needle" ]] && return 0
    done
    return 1
}

# Check if a key exist in an array
# @param $1 mixed  Key
# @param $2 array  Haystack
# @return  Success (0) if value exists, Failure (1) otherwise
function array::keyExists() {
    local key=$1
    local array=$2
    [[ ${array[key]+abc} ]] && return 0
    return 1
}
