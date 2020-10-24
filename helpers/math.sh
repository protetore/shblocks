#!/usr/bin/env bash
#
# Math functions
#
# Protetore Shell Util Package
# github.com.protetore/shblocks.git
#

function math::floor() {
    local number=$1
    local digits=$2
    digits=${digits:=0}
    printf "%.*f\n" "${digits}" "${number}"
}

function math::ceil() {
    printf %.0f "$1"
}
