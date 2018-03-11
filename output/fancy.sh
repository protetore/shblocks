#!/bin/bash
#
# More fancy function to control app output
#
# Protetore Shell Util Package
# github.com.protetore/shblocks.git
#

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

fancy::header() { printf "\n${bold}${purple}==========  %s  ==========${reset}\n" "$@" }
fancy::arrow() { printf "➜ $@\n" }
fancy::success() { printf "${green}✔ %s${reset}\n" "$@" }
fancy::error() { printf "${red}✖ %s${reset}\n" "$@" }
fancy::warning() { printf "${tan}➜ %s${reset}\n" "$@" }
fancy::underline() { printf "${underline}${bold}%s${reset}\n" "$@" }
fancy::bold() { printf "${bold}%s${reset}\n" "$@" }
fancy::note() { printf "${underline}${bold}${blue}Note:${reset}  ${blue}%s${reset}\n" "$@" }

# USAGE FOR SEEKING CONFIRMATION
# seek_confirmation "Ask a question"
# Credt: https://github.com/kevva/dotfiles
#
# if is_confirmed; then
#   some action
# else
#   some other action
# fi
fancy::confirm() {
    printf "\n${bold}$@${reset}"
    read -p " (y/n) " -n 1
    printf "\n"
}

# underlined
fancy::confirm_head() {
    printf "\n${underline}${bold}$@${reset}"
    read -p "${underline}${bold} (y/n)${reset} " -n 1
    printf "\n"
}

# Test whether the result of an 'ask' is a confirmation
fancy::is_confirmed() {
    if [[ "$REPLY" =~ ^[Yy]$ ]]; then
      return 0
    fi
    return 1
}
