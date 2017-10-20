#!/bin/bash
# ------------------------------------------------------------
# title           :string.sh
# description     :Useful functions to handle strings
# package         :shblocks
# author          :protetore
# date            :20150127
# bash_version    :4.1.5(1)-release
# ------------------------------------------------------------

# Convert a camelized string to separate words
# @param $1 string CamelizedString
# @return  string The converted string
# Usage: camel2words "$string"
camel2words() {
    words=$(sed -e 's/\([A-Z][A-Z]{n}\)/ \1/g' -e 's/msgid \" /msgid \"/' -e 's/msgstr \" /msgstr \"/g' -e 's|\([a-z]\)\([A-Z]\)|\1 \2|g' -e 's|\([A-Z][A-Z]\)\([a-z]\)|\1 \U\2|g' <<< $1)
    return $words
}

# Convert a underscore string to CamelCase
# @param $1 string underscore_string
# @return  string The converted string
# Usage: underscore2camel "$string"
underscore2camel() {
    #First char uppercase
    #camelized=$(sed -e 's#\(\%(\<\l\+\)\%(_\)\@=\)\|_\(\l\)#\u\1\2#g' <<< $1)
    #First char lowercase
    camelized=$(sed -e 's#_\(\l\)#\u\1#g' <<< $1)
    return $camelized
}

# Convert a camelized string to underscore separated string
# @param $1 string CamelizedString
# @return  string The converted string
# Usage: camel2underscore "$string"
camel2underscore() {
    underscore=$(sed -e 's#\C\(\<\u[a-z0-9]\+\|[a-z0-9]\+\)\(\u\)#\l\1_\l\2#g' <<< $1)
    return $underscore
}
