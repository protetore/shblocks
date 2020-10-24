#!/usr/bin/env bash
#
# Print user friendly and colored messages
#
# Protetore Shell Util Package
# github.com.protetore/shblocks.git
#

if [[ $_ != "$0" ]]; then
    CWD=$(dirname "${BASH_SOURCE[0]}")
else
    CWD=$(dirname "$0")
fi

source "${CWD}/colors.sh"

# Configure output
OUTPUT_SHOW_DATE=0

# Message types
readonly OUTPUT_ERR="ERR"
readonly OUTPUT_WRN="WRN"

# Font Effects
readonly OUTPUT_BOLD="\033[1m"
readonly OUTPUT_ITALIC="\033[3m"
readonly OUTPUT_UNDERLINE="\033[4m"
readonly OUTPUT_STRIKE="\033[9m"
readonly OUTPUT_BLINK="\033[5m"

# Turn on/off datetime on output
function logger::showDate() { OUTPUT_SHOW_DATE=1; }
function logger::hideDate() { OUTPUT_SHOW_DATE=0; }

# Print messages to stdout or stderr if VERBOSE mode is enabled
#
# Arguments:
#   - $1 string The message
#   - $2 string Type of message ($OUTPUT_ERR|$OUTPUT_WRN)
function logger::out() {
    local timestamp=""

    if [ "$OUTPUT_SHOW_DATE" == "1" ]; then
        timestamp=$(date +"%Y-%m-%d %T")
        timestamp="[${timestamp}]"

        if [ "$2" == "$OUTPUT_ERR" ]; then
            # Send to stderr
            echo -n -e "${COLORS_GRAY}${timestamp} $1" 1>&2
        else
            echo -n -e "${COLORS_GRAY}${timestamp} $1"
        fi
    else
        if [ "$2" == "$OUTPUT_ERR" ]; then
            # Send to stderr
            echo -n -e "$1" 1>&2
        else
            echo -n -e "$1"
        fi
    fi
}

# Simple message with no color
function logger::echo() { logger::out "${COLORS_RESET}$1${COLORS_RESET}\n"; }

# Indented sub activity
function logger::step() { logger::out "${COLORS_RESET}- $1${COLORS_RESET}\n"; }

# Error message in RED
function logger::error() { logger::out "${COLORS_BKG_RED} ${OUTPUT_ERR} ${COLORS_BKG_RESET} ${COLORS_RED}$1${COLORS_RESET}\n" "${OUTPUT_ERR}"; }

# Warning message in ORANGE
function logger::warn() { logger::out "${COLORS_BKG_ORANGE} ${OUTPUT_WRN} ${COLORS_BKG_RESET} ${COLORS_ORANGE}$1${COLORS_RESET}\n"; }

# Success message in GREEN
function logger::success() { logger::out "${COLORS_GREEN}$1${COLORS_RESET}\n"; }

# Sub title using BLUE
function logger::sub() { logger::out "${COLORS_CYAN}@ $1${COLORS_RESET}\n"; }

# Processing message - blinking
function logger::wait() { logger::out "${OUTPUT_BLINK}█ ${COLORS_RESET}\n"; }

# Bold
function logger::bold() { logger::out "${OUTPUT_BOLD}$1${COLORS_RESET}\n"; }

# Underline
function logger::bold() { logger::out "${OUTPUT_UNDERLINE}$1${COLORS_RESET}\n"; }

# Italic
function logger::italic() { logger::out "${OUTPUT_ITALIC}$1${COLORS_RESET}\n"; }

# Striketrough
function logger::striketrough() { logger::out "${OUTPUT_STRIKE}$1${COLORS_RESET}\n"; }

# Debug title using YELLOW
function logger::title() {
    title=$(echo "$1" | tr '[:lower:]' '[:upper:]')
    logger::out "${COLORS_YELLOW}********** ${title} *********${COLORS_RESET}\n"
}

# Print code blocks in one color
# TODO: Receive type and add syntax highlight
function logger::code() { logger::out "${COLORS_BLUE}$1${COLORS_RESET}\n"; }

# Print conf snipets in different color
function logger::conf() { logger::out "${COLORS_PURPLE}$1${COLORS_RESET}\n"; }

# Print padded key -> value
function logger::keyVal() {
    local keyColSize=30
    local key=$1
    local val=$2
    local padChar=$3
    local padded
    local padSize
    local keySize=${#key}

    padSize=$((keyColSize - keySize))
    padChar=${padChar:="."}

    printf -v row "%${padSize}s"
    padded=${row// /${padChar}}
    printf "%s\n" "${key} ${padded} ${val}"
}
