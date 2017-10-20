#!/bin/bash
# ------------------------------------------------------------
# title           :output/fancy.sh
# description     :More fancy function to control app output
# package         :shblocks
# author          :protetore
# date            :20150830
# bash_version    :4.1.5(1)-release
# ------------------------------------------------------------

#
# Set Colors
#

bold=$(tput bold)
underline=$(tput sgr 0 1)
reset=$(tput sgr0)

purple=$(tput setaf 171)
red=$(tput setaf 1)
green=$(tput setaf 76)
tan=$(tput setaf 3)
blue=$(tput setaf 38)

#
# Headers and  Logging
#

e_header() { printf "\n${bold}${purple}==========  %s  ==========${reset}\n" "$@" }
e_arrow() { printf "➜ $@\n" }
e_success() { printf "${green}✔ %s${reset}\n" "$@" }
e_error() { printf "${red}✖ %s${reset}\n" "$@" }
e_warning() { printf "${tan}➜ %s${reset}\n" "$@" }
e_underline() { printf "${underline}${bold}%s${reset}\n" "$@" }
e_bold() { printf "${bold}%s${reset}\n" "$@" }
e_note() { printf "${underline}${bold}${blue}Note:${reset}  ${blue}%s${reset}\n" "$@" }

# USAGE FOR SEEKING CONFIRMATION
# seek_confirmation "Ask a question"
# Credt: https://github.com/kevva/dotfiles
#
# if is_confirmed; then
#   some action
# else
#   some other action
# fi
seek_confirmation() {
    printf "\n${bold}$@${reset}"
    read -p " (y/n) " -n 1
    printf "\n"
}

# underlined
seek_confirmation_head() {
    printf "\n${underline}${bold}$@${reset}"
    read -p "${underline}${bold} (y/n)${reset} " -n 1
    printf "\n"
}

# Test whether the result of an 'ask' is a confirmation
is_confirmed() {
    if [[ "$REPLY" =~ ^[Yy]$ ]]; then
      return 0
    fi
    return 1
}
