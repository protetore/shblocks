#!/bin/bash
# ------------------------------------------------------------
# title           :alerting/slack.sh
# description     :Send notification to slack
# package         :shblocks
# author          :protetore
# date            :20150127
# bash_version    :4.1.5(1)-release
# ------------------------------------------------------------

function notifySlack()
{
    SLACK_HOOK=${1:-}
    SLACK_CHANNEL=${2:-}
    TYPE=${3:="INFO"}

    if [ "$SLACK_HOOK" == "" ] || [ "$SLACK_CHANNEL" == "" ];
    then
        return 0
    fi

    # format message as a code block ```${msg}```
    SLACK_MESSAGE="\`\`\`$1\`\`\`"
    SLACK_URL=https://hooks.slack.com/services/${SLACK_HOOK}

    case "$messageType" in
        INFO)
            SLACK_ICON=''
            ;;
        WARNING)
            SLACK_ICON=':warning:'
            ;;
        ERROR)
            SLACK_ICON=':bangbang:'
            ;;
        *)
            SLACK_ICON=''
            ;;
    esac

    #-o /dev/null -w "%{http_code}"
    status=$(curl -s -X POST --data "payload={\"text\": \"${SLACK_ICON} ${SLACK_MESSAGE}\", \"username\": \"ship\", \"channel\": \"${SLACK_CHANNEL}\"}" ${SLACK_URL})

    if [ "$status" == "ok" ];
    then
        return 0
    else
        return 1
    fi
}
