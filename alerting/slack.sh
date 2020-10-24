#!/usr/bin/env bash
#
# Send a slack message to a channel
#
# Protetore Shell Util Package
# github.com.protetore/shell-blocks.git
#

SLACK_HOOK=""
SLACK_CHANNEL=""

function slack::setHook() { SLACK_HOOK=$1; }
function slack::setChannel() { SLACK_CHANNEL=$1; }

# Post a message to a Slack hook
# @param $1 string The message
# @param $2 string Message type (INFO|WARNING|ERROR)
function slack::send() {
    if [ "$SLACK_HOOK" == "" ]; then
        echo "Missing hook - use 'slack::setHook' to configure" 1>&2
        return 1
    fi

    if [ "$SLACK_CHANNEL" == "" ]; then
        echo "Missing channel - use 'slack::setChannel' to configure" 1>&2
        return 1
    fi

    # format message as a code block ```${msg}```
    SLACK_MESSAGE="\`\`\`$1\`\`\`"
    SLACK_URL=https://hooks.slack.com/services/${SLACK_HOOK}

    if [ "$2" == "" ]; then
        messageType="INFO"
    else
        messageType=$2
    fi

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

    if [ "$status" == "ok" ]; then
        decho "Slack notified."
        return 0
    else
        derror "Error notifying Slack."
        return 1
    fi
}
