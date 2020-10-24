#!/usr/bin/env bash
#
# More fancy function to control app output
#
# Protetore Shell Util Package
# github.com.protetore/shblocks.git
#

#
# Set Colors
#
readonly _BOLD=$(tput bold)
readonly _UNDERLINE=$(tput sgr 0 1)
readonly _RESET=$(tput sgr0)

# USAGE FOR SEEKING CONFIRMATION
# confirm::confirm "Ask a question"
#
# if confirm::isConfirmed; then
#   some action
# else
#   some other action
# fi
confirm::confirm() {
    printf "\n${_BOLD}%s${_RESET}" "$@"
    read -p " (y/n) " -n 1
    printf "\n"
}

# Ask for confirmation in underline
confirm::confirmHead() {
    printf "\n${_UNDERLINE}${_BOLD}%s${_RESET}" "$@"
    read -p "${_UNDERLINE}${_BOLD} (y/n)${_RESET} " -n 1
    printf "\n"
}

# Test whether the result of the confirm method is positive
confirm::isConfirmed() {
    if [[ "$REPLY" =~ ^[Yy]$ ]]; then
        return 0
    fi
    return 1
}

# Ask for user input
confirm::ask() {
    printf "\n${_BOLD}%s${_RESET}" "$@"
    read -p ": "
}

# Ask for user input
confirm::answer() {
    echo -n "${REPLY}"
}
