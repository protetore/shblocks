#!/bin/bash
# ------------------------------------------------------------
# title           :helpers/array.sh
# description     :Useful functions to handle arrays
# package         :shblocks
# author          :protetore
# date            :20150127
# bash_version    :4.1.5(1)-release
# ------------------------------------------------------------


# Check if a value exists in an array
# @param $1 mixed  Needle
# @param $2 array  Haystack
# @return  Success (0) if value exists, Failure (1) otherwise
# Usage: in_array "$needle" "${haystack[@]}"
in_array() {
    local hay needle=$1
    shift
    for hay; do
        [[ $hay == $needle ]] && return 0
    done
    return 1
}
