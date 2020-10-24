#!/bin/bash
#
# Print progress bar or simple wait bar
#
# Protetore Shell Util Package
# github.com.protetore/shblocks.git
#

PROGRESS_CHAR="\*"
PROGRESS_FILL="-"

function progress::wait() {
    local max=$1
    for ((i = 1; i <= max; i++)); do
        left=$((max - i))
        currText=$(printf '%*s\n' "${i}" '' | tr ' ' "${PROGRESS_CHAR}")
        leftText=$(printf '%*s\n' "${left}" '' | tr ' ' "${PROGRESS_FILL}")
        echo -ne "[${currText}${leftText}]\r"
        sleep 1
    done
    printf '\n'
}
