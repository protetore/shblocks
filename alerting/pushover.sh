#!/bin/bash
# ------------------------------------------------------------
# title           :alerting/pushover.sh
# description     :Send Pushover notifications
# package         :shblocks
# author          :protetore
# date            :20150127
# bash_version    :4.1.5(1)-release
# usage           :pushover "Title Goes Here" "Message Goes Here"
# ------------------------------------------------------------
#
# Based on: http://ryonsherman.blogspot.com/2012/10/shell-script-to-send-pushover.html

pushover () {
    PUSHOVERURL="https://api.pushover.net/1/messages.json"
    API_KEY=${PUSHOVER_API_KEY:?}
    USER_KEY=${PUSHOVER_USER_KEY:?}
    DEVICE=${PUSHOVER_DEVICE:-}

    TITLE="${1:?}"
    MESSAGE="${2:?}"
    DEVICE=${3:=$DEVICE}

    curl \
    -F "token=${API_KEY}" \
    -F "user=${USER_KEY}" \
    -F "device=${DEVICE}" \
    -F "title=${TITLE}" \
    -F "message=${MESSAGE}" \
    "${PUSHOVERURL}" > /dev/null 2>&1
}
