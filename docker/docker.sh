#!/bin/bash
# ------------------------------------------------------------
# title           :docker/images.sh
# description     :Useful functions to operate docker images
# package         :shblocks
# author          :protetore
# date            :20150127
# bash_version    :4.1.5(1)-release
# ------------------------------------------------------------

function isRegistryAccessible()
{
    REGISTRY_URL=${1:-}
    REGISTRY_USR=${2:-}
    REGISTRY_PWD=${3:-}
    REGISTRY_AUTH="${REGISTRY_USR}:${REGISTRY_PWD}"

    if [ "$REGISTRY_URL" != "" ]; then
        # Private registry
        if [ "$REGISTRY_USR" != "" ]; then
            docker login $REGISTRY_URL -u $REGISTRY_USR -p $REGISTRY_PWD > /dev/null 2>&1
            if [ ! $? -eq 0 ]; then
                return 1
            fi
        else
            status=$(curl -s -o /dev/null -w "%{http_code}" -k https://$REGISTRY_URL/v2/)
            if [ "$status" != "200" ]; then
                return 1
            fi
        fi
    else
        # Docker hub?
        status=$(curl -s -o /dev/null -w "%{http_code}" -k https://hub.docker.com/v2/repositories/_catalog/)
        if [ "$status" != "200" ]; then
            return 1
        fi
    fi

    return 0
}

function getNextAvailablePort()
{
    usedPorts=$(\
        docker ps --filter "label=ship-user-container" --format "{{.Ports}}" | \
        tr ',' '\n' | \
        sed 's/\/tcp//g' | \
        sed 's/\/udp//g' | \
        awk -F'->' '{print $1}' | \
        awk -F":" '{ print $2 }'
    )

    m=1000
    for p in ${usedPorts[@]}
    do
        if [ $p -gt $m ];
        then
            m=$p
        fi
    done

    m=$((m+1))

    echo $m
}

function imageTagExists()
{
    REGISTRY_URL=${1:-}
    REGISTRY_USR=${2:-}
    REGISTRY_PWD=${3:-}
    REGISTRY_AUTH="${REGISTRY_USR}:${REGISTRY_PWD}"

    status=$(curl -s -o /dev/null -w "%{http_code}" -k $REGISTRY_AUTH https://$REGISTRY_URL/v2/$APP_NAME/manifests/$APP_VERSION)
    if [ "$status" == "200" ]; then
        return 0
    else
        return 1
    fi
}

function getNextTag()
{
    REGISTRY_URL=${1:-}
    REGISTRY_USR=${2:-}
    REGISTRY_PWD=${3:-}
    REGISTRY_AUTH="${REGISTRY_USR}:${REGISTRY_PWD}"

    latestTag=0
    tags=$(curl -s -k $REGISTRY_AUTH https://$REGISTRY_URL/v2/$APP_NAME/tags/list)

    if echo "$tags" | $JQ -e 'has("tags")' > /dev/null; then
        tagsArr=( $(echo $tags | $JQ '.tags[]') )

        for tag in ${tagsArr[@]}
        do
            # Remove double quotes from json value
            tag=$(echo $tag | tr -d '"')

            # Ignore tags that aren't numbers
            regex='^[0-9]+$'
            if ! [[ $tag =~ $regex ]] ; then
               continue
            fi

            if [[ $tag -gt $latestTag ]];
            then
                latestTag=$tag
            fi
        done
    fi

    echo $(( latestTag + 1 ))
}

function dockerImagesByRepo()
{
    REPO=${1:-}
    previousImages=$(docker images | grep -w "${REPO}" | awk '{ print $3 }')

    if [ ! "$previousImages" == "" ];
    then
        previousImages=$(echo $previousImages | tr '\n' ' ')
        previousImages=${previousImages%?}
        # Skip error output because some images can be in use
        status=$(docker rmi -f $previousImages > /dev/null 2>&1)
    fi
}

function dockerCleanImages()
{
    # Skip error output because some images can be in use
    docker images | grep none | awk '{ print \$3 }' | xargs -I{} docker rmi -f {} > /dev/null 2>&1
}
