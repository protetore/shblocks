#!/usr/bin/env bash
#
# Useful functions to operate docker images
#
# Protetore Shell Util Package
# github.com.protetore/shblocks.git
#

function docker::isRegistryAccessible() {
    local registryURL=${1:-}
    local registryUSR=${2:-}
    local registryPWD=${3:-}
    local registryAUTH="${registryUSR}:${registryPWD}"
    local status

    if [ "$registryURL" != "" ]; then
        # Private registry
        if [ "$registryUSR" != "" ]; then
            docker login $registryURL -u $registryUSR -p $registryPWD > /dev/null 2>&1
            if [ ! $? -eq 0 ]; then
                return 1
            fi
        else
            status=$(curl -s -o /dev/null -w "%{http_code}" \
                       -k https://$registryURL/v2/)
            if [ "$status" != "200" ]; then
                return 1
            fi
        fi
    else
        # Docker hub?
        status=$(curl -s -o /dev/null -w "%{http_code}" \
                   -k https://hub.docker.com/v2/repositories/_catalog/)

        if [ "$status" != "200" ]; then
            return 1
        fi
    fi

    return 0
}

function docker::nextAvailablePort() {
    local usedPorts m

    usedPorts=$(\
        docker ps --filter "label=ship-user-container" --format "{{.Ports}}" | \
        tr ',' '\n' | \
        sed 's/\/tcp//g' | \
        sed 's/\/udp//g' | \
        awk -F'->' '{print $1}' | \
        awk -F":" '{ print $2 }'
    )

    m=1000
    for p in ${usedPorts[@]}; do
        if [ $p -gt $m ]; then
            m=$p
        fi
    done

    m=$((m+1))

    echo $m
}

function docker::tagExists() {
    local status
    local registryAPP=${1:-}
    local registryTAG=${2:-}
    local registryURL=${3:-}
    local registryUSR=${4:-}
    local registryPWD=${5:-}
    local registryAUTH="${registryUSR}:${registryPWD}"

    status=$(curl -s -o /dev/null -w "%{http_code}" \
        -k $registryAUTH \
        https://$registryURL/v2/$registryAPP/manifests/$registryTAG)

    if [ "$status" == "200" ]; then
        return 0
    else
        return 1
    fi
}

function docker::nextTag() {
    local registryAPP=${1:-}
    local registryURL=${2:-}
    local registryUSR=${3:-}
    local registryPWD=${4:-}
    local registryAUTH="${registryUSR}:${registryPWD}"
    local latestTag=0
    local tag tagsArr regex

    tags=$(curl -s -k $registryAUTH https://$registryURL/v2/$registryAPP/tags/list)

    if echo "$tags" | $JQ -e 'has("tags")' > /dev/null; then
        tagsArr=( $(echo $tags | $JQ '.tags[]') )

        for tag in ${tagsArr[@]}; do
            # Remove double quotes from json value
            tag=$(echo $tag | tr -d '"')

            # Ignore tags that aren't numbers
            regex='^[0-9]+$'
            if ! [[ $tag =~ $regex ]] ; then
               continue
            fi

            if [[ $tag -gt $latestTag ]]; then
                latestTag=$tag
            fi
        done
    fi

    echo $(( latestTag + 1 ))
}

function docker::imagesByRepo() {
    local previousImages
    local repo=${1:-}

    previousImages=$(docker images | grep -w "${repo}" | awk '{ print $3 }')

    if [ ! "$previousImages" == "" ]; then
        previousImages=$(echo $previousImages | tr '\n' ' ')
        previousImages=${previousImages%?}
        # Skip error output because some images can be in use
        status=$(docker rmi -f $previousImages > /dev/null 2>&1)
    fi
}

function docker::cleanImages() {
    # Skip error output because some images can be in use
    docker images | grep none | awk '{ print \$3 }' | \
        xargs -I{} docker rmi -f {} > /dev/null 2>&1
}
