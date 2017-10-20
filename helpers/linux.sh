#!/bin/bash
# ------------------------------------------------------------
# title           :helpers/linux.sh
# description     :Useful linux functions
# package         :shblocks
# author          :protetore
# date            :20150127
# bash_version    :4.1.5(1)-release
# ------------------------------------------------------------

# Check if a user exists
# @param $1 string user
# @return  Success (0) if exists, Failure (1) otherwise
# Usage: user_exists "$username"
user_exists() {
        ret=1
        getent passwd $1 >/dev/null 2>&1 && ret=0

        if [ "$ret" == "0" ]; then
                retval=0
        else
                retval=1
        fi

        return $retval
}

# Check if a group exists
# @param $1 string group
# @return  Success (0) if exists, Failure (1) otherwise
# Usage: group_exists "$groupname"
group_exists() {
    ret=1
    getent group $1 >/dev/null 2>&1 && ret=0

    if [ "$ret" == "0" ]; then
        retval=0
    else
        retval=1
    fi

    return $retval
}

# Check if a package is installed on system
# @param $1 string packagename, $2 d flag users dpkg instead of rpm
# @return  Success (0) if installed, Failure (1) otherwise
# Usage: package_exists "$packagename"
package_exists() {
    if [ "$2" == "d" ]; then
        pkg=$(dpkg -l | grep $1)
    else
        pkg=$(rpm -qa | grep $1)
    fi

    if [ "$pkg" == "" ]; then
        retval=1
    else
        retval=0
    fi

    return $retval
}

# Check if a RPM package is installed on system
# @param $1 string packagename
# @return  Success (0) if installed, Failure (1) otherwise
# Usage: package_exists "$packagename"
rpm_package_exists() {
    package_exists $1
    return $?
}

# Check if a dpkg package is installed on system
# @param $1 string packagename
# @return  Success (0) if installed, Failure (1) otherwise
# Usage: package_exists "$packagename"
dpkg_package_exists() {
    package_exists $1 d
    return $?
}

# Check if a proccess is running by it's name or part of t
# @param $1 string proccessname
# @return  Success (0) if running, Failure (1) otherwise
# Usage: is_running "$proccessname"
is_running() {
    if [ $(ps -e -o uid,cmd | grep $UID | grep $1 | grep -v grep | grep -v bash | grep -v $0 | wc -l | tr -s "\n") -eq 0 ]
    then
        retval=1
    else
        retval=0
    fi
    return $retval
}

# Return all PIDs of a given proccess name
# @param $1 string proccessname
# @return  array of PIDs if running, Failure (1) otherwise
# Usage: get_pids "$proccessname"
get_pids() {
    if [ $(ps -e -o uid,cmd | grep $UID | grep $1 | grep -v grep | grep -v bash | grep -v $0 | wc -l | tr -s "\n") -eq 0 ]
    then
        retval=1
    else
        pids=$(ps -edf | grep $1 | grep -v grep | grep -v bash | grep -v $0 | awk '{print $2}')
        pids2=`echo $pids | tr '\n' ' '`
        retval=${pids2%?}
    fi

    return $retval
}

# Test whether a command exists
# @param $1 = cmd to test
# @return  Success (0) on success, Failure (1) otherwise
# Usage:
# if type_exists 'git'; then
#   some action
# else
#   some other action
# fi
type_exists() {
    if [ $(type -P $1) ]; then
      return 0
    fi
    return 1
}

# Test which OS the user runs
# @param $1 = OS to test
# @return  Success (0) on success, Failure (1) otherwise
# Usage: if is_os 'darwin'; then
is_os() {
    if [[ "${OSTYPE}" == $1* ]]; then
      return 0
    fi
    return 1
}
