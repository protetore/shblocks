#!/usr/bin/env bash
#
# Print user friendly table
#
# Protetore Shell Util Package
# github.com.protetore/shblocks.git
#

if [[ $_ != "$0" ]]; then
    CWD=$(dirname "${BASH_SOURCE[0]}")
else
    CWD=$(dirname "$0")
fi

source "${CWD}/format.sh"


table::row() {
    row="│"
    for columnValue in "$@"; do
        value=$(echo "${columnValue}" | cut -d ":" -f 1)
        colSize=$(echo "${columnValue}" | cut -d ":" -f 2)
        position=$(echo "${columnValue}" | cut -d ":" -f 3)

        if [[ "${position}" = "r" ]]; then
            paddedValue=$(format::paddingLeft "${value}" "${colSize}")
        elif [[ "${position}" = "c" ]]; then
            paddedValue=$(format::paddingCenter "${value}" "${colSize}")
        else
            paddedValue=$(format::paddingRight "${value}" "${colSize}")
        fi

        row="${row} ${paddedValue} │"
    done
    echo -e "${row}"
}

table::header() {
    row=$(printTableRow "$@")
    # Compensate for the bigger byte size of utf-8 chars
    maxSize=$((${#row} - (($# + 1) * 2) - 2))
    dividerTemplate=$(printf "%${maxSize}s")
    echo "┌${dividerTemplate// /─}┐"
    echo -e "${row}"
    echo "├${dividerTemplate// /─}┤"
}

table::footer() {
    row=$(printTableRow "$@")
    # Compensate for the bigger byte size of utf-8 chars
    maxSize=$((${#row} - (($# + 1) * 2) - 2))
    dividerTemplate=$(printf "%${maxSize}s")
    echo "├${dividerTemplate// /─}┤"
    echo -e "${row}"
    echo "└${dividerTemplate// /─}┘"
}

table::divider() {
    numCols=$#
    maxSize=$((numCols * 3 - 1))
    for i in "$@"; do
        maxSize=$((maxSize+i))
    done
    dividerTemplate=$(printf "%${maxSize}s")
    echo "├${dividerTemplate// /─}┤"
}