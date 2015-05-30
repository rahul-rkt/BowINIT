#!/bin/bash
# -----------------------------------------------------------------------------
#          FILE:  configure.sh
#   DESCRIPTION:  Configures your environment according to config.json.
#        AUTHOR:  Rahul Thakur <rahul.rkt@gmail.com>
#       VERSION:  1.0
# -----------------------------------------------------------------------------



# Exit
clear
tac $rc | sed "1,1{d}" | tac > $rc
echo -e "\n\n\e[1;92mYour Bowery environment has been fully provisioned. Save, restart and happy coding :)\e[0;0m\n\n" >> $log
t=$((`date +%s` + 10))
while [[ "$t" -ne `date +%s` ]]; do
    echo -ne "Exiting in.. $(date -u --date @$(($t - `date +%s` )) +%H:%M:%S)\r" >> $log
done
exit $?
