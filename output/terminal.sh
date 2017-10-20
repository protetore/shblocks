#!/bin/bash
# ------------------------------------------------------------
# title           :output/fancy.sh
# description     :Simple function to gen more elegant output
# package         :shblocks
# author          :protetore
# date            :20160112
# bash_version    :4.1.5(1)-release
# ------------------------------------------------------------

DEBUG_DATE=0

# Message types
ERR="ERR"
WRN="WRN"
INF="INF"

# Regular Colors [Foreground]
TERM_COLOR_DEFAULT='\033[0m' # No Color
TERM_COLOR_GRAY='\033[0;37m'
TERM_COLOR_CYAN='\033[0;36m'
TERM_COLOR_RED='\033[0;31m'
TERM_COLOR_GREEN='\033[0;32m'
TERM_COLOR_ORANGE='\033[0;33m'
TERM_COLOR_YELLOW='\033[1;33m'
TERM_COLOR_LIGHTBLUE='\033[0;94m'
TERM_COLOR_WHITE='\033[1;37m'
TERM_COLOR_PURPLE='\033[0;35m'
TERM_COLOR_BLUE='\033[0;34m'
# TERM_COLOR_BLACK='\033[0;30m'

# Regular Colors [Background]
TERM_BKG_NC='\033[0;49m'
TERM_BKG_RED='\033[0;41m'
TERM_BKG_LIGHTBLUE='\033[0;104m'
# TERM_BKG_ORANGE='\033[0;43m'

# Style
TERM_STYLE_UNDERLINE="\033[4m"
TERM_STYLE_BLINK="\033[5m"

# Print messages to stdout or stderr if VERBOSE mode is enabled
function debug()
{
    if [ "$1" == "printf" ];
    then
        shift
        if [ $# -eq 1 ];
        then
            printf "$1"
        else
            printf "$@"
        fi
    else
        tmstmp=""
        if [ "$DEBUG_DATE" == "1" ];
        then
          tmstmp=$(date +"%Y-%m-%d %T")
          tmstmp="[$tmstmp] "
        fi

        if [ "$2" == "$ERR" ];
        then
            # Send to stderr
            printf "${TERM_COLOR_GRAY}${tmstmp}$1" 1>&2
        else
            printf "${TERM_COLOR_GRAY}${tmstmp}$1"
        fi
    fi
}

# debug using printf
function dprintf() { debug printf $@; }
# Debug using no color
function decho() { debug "${TERM_COLOR_DEFAULT}$1${TERM_COLOR_DEFAULT}\n"; }
# Debug sub activity
function dstep() { debug "${TERM_COLOR_DEFAULT}    - $1${TERM_COLOR_DEFAULT}\n"; }
# Debug using RED for error
function derror() { debug "${BKG_RED} $ERR ${BKG_NC} ${TERM_COLOR_RED}$1${TERM_COLOR_DEFAULT}\n"; }
# Debug using ORANGE for warning
function dwarn() { debug "${BKG_LIGHTBLUE} $WRN ${BKG_NC} ${TERM_COLOR_LIGHTBLUE}$1${TERM_COLOR_DEFAULT}\n"; }
# Debug using GREEN for warning
function dsuccess() { debug "${TERM_COLOR_GREEN}$1${TERM_COLOR_DEFAULT}\n"; }
# Debug sub title using BLUE
function dsub() { debug "${TERM_COLOR_CYAN}@ $1${TERM_COLOR_DEFAULT}\n"; }
# Processing message - blinking
function dwait() { debug "${TERM_COLOR_LIGHTBLUE}█ ${TERM_COLOR_DEFAULT}\n"; }
# Debug title using YELLOW
function dtitle() {
  title=$(echo $1 | tr '[:lower:]' '[:upper:]')
  debug "${TERM_COLOR_YELLOW}********** $title *********${TERM_COLOR_DEFAULT}\n";
}
# Print code blocks in one color
function dcode() { debug "${TERM_COLOR_BLUE}$1${TERM_COLOR_DEFAULT}\n"; }
# Print conf snipets in different color
function dconf() { debug "${TERM_COLOR_PURPLE}$1${TERM_COLOR_DEFAULT}\n"; }
