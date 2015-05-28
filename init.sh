#!/bin/bash
# -----------------------------------------------------------------------------
#          FILE:  init.sh
#   DESCRIPTION:  BowINIT master script.
#        AUTHOR:  Rahul Thakur <rahul.rkt@gmail.com>
#       VERSION:  1.0
# -----------------------------------------------------------------------------


# Make elements
if [ -z "$stager" ]; then
    # Install BowINIT
    echo -e "\n\e[1;94mInstalling BowINIT, hold on..\e[0;0m"
    dir=~/.bowinit
    if [ -d "$dir" ]; then
        echo -e "\n\e[1;91mFound previous copy of BowINIT. Please note that all scripts will be refired!\e[0;0m\n"
        rm -rf $dir
    fi
    git clone git://github.com/rahul-rkt/BowINIT.git $dir/BowINIT

    # Determine shell
    sh="$(ps -p $$ --no-headers -o comm=)"
    if [[ $sh == "bash" || $sh == "sh" ]]; then
        rc=~/.bashrc
    elif [[ $sh == "zsh" ]]; then
        rc=~/.zshrc
    else
        echo -e "\n\e[1;91mUNSUPPORTED SHELL. BowINIT will exit now..\e[0;0m\n"
        exit 0
    fi

    # Make elements
    log=$dir/log
    vars=$dir/vars
    pid=$dir/pid
    bowinit=$dir/BowINIT
    config=$bowinit/config.json
    touch $log $vars $pid
    stager=0
    echo -e "export dir=$dir\nexport log=$log\nexport vars=$vars\nexport pid=$pid\nexport bowinit=$bowinit\nexport config=$config\nexport rc=$rc\nexport stager=$stager\nsource $bowinit/init.sh" > $vars

    # Open config
    "${EDITOR:-vi}" $config
fi


# First pass
if [ $stager -eq 0 ]; then
    source $bowinit/scripts/update.sh &
fi


# Second pass
if [ $stager -eq 1 ]; then
    source $bowinit/scripts/install.sh &
fi


# Third pass
if [ $stager -eq 2 ]; then
    source $bowinit/scripts/configure.sh &
fi


# Start scrolling
#tput reset
sleep .1
trap 'kill -TERM -$(head -n 1 $pid); kill -TERM -$$' INT
tput csr "$((1+7))" "$((LINES-1))"
tput clear
{
head -n "7"
printf "%${COLUMNS}s\n" "" | tr ' ' =
tail -n "$((LINES-1-7))" -f --pid=$(head -n 1 $pid) 2> /dev/null
} < $log


tput reset
exit 0
