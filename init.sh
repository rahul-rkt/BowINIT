#!/bin/bash
# -----------------------------------------------------------------------------
#          FILE:  init.sh
#   DESCRIPTION:  BowINIT master script.
#        AUTHOR:  Rahul Thakur <rahul.rkt@gmail.com>
#       VERSION:  1.0
# -----------------------------------------------------------------------------


# Prelude
if [ -z "$stager" ]; then
    # Determine shell & dir
    sh="$(ps -p $$ --no-headers -o comm=)"
    if [[ $sh == "bash" || $sh == "sh" ]]; then
        dir=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
        rc=~/.bashrc
    elif [[ $sh == "zsh" ]]; then
        dir=$(cd "$(dirname "$0")" && pwd)
        rc=~/.zshrc
    else
        echo -e "\n\e[1;91mUNSUPPORTED SHELL. BowINIT will exit now..\e[0;0m\n"
        exit $?
    fi

    # Make elements
    rm -rf $dir/tmp/
    log=$dir/tmp/log
    vars=$dir/tmp/vars
    pid=$dir/tmp/pid
    config=$dir/config.json
    mkdir $dir/tmp
    touch $log $vars $pid
    stager=0
    echo -e "export dir=$dir\nexport log=$log\nexport vars=$vars\nexport pid=$pid\nexport config=$config\nexport rc=$rc\nexport stager=$stager\nsource $dir/init.sh" > $vars
fi


# First pass
if (( $stager == 0 )); then
    source $dir/scripts/update.sh &
fi


# Second pass
if (( $stager == 1 )); then
    source $dir/scripts/install.sh &
fi


# Third pass
if (( $stager == 2 )); then
    source $dir/scripts/configure.sh &
fi


# Start scrolling
sleep 1
trap 'kill -TERM -$(head -n 1 $pid); kill -TERM -$$' INT
tput csr "$((1+7))" "$((LINES-1))"
tput clear
{
head -n "7"
printf "%${COLUMNS}s\n" "" | tr ' ' =
tail -n "$((LINES-1-7))" -f --pid=$(head -n 1 $pid) 2> /dev/null
} < $log


tput reset
