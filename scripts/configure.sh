#!/bin/bash
# -----------------------------------------------------------------------------
#          FILE:  configure.sh
#   DESCRIPTION:  Configures your environment according to config.json.
#        AUTHOR:  Rahul Thakur <rahul.rkt@gmail.com>
#       VERSION:  1.0
# -----------------------------------------------------------------------------



# Exit
clear
tac $rc | sed "1,7{d}" | tac > $rc
echo -e "\nYour Bowery environment has been fully provisioned. Save, restart and happy coding.\n\n"
t=$((`date +%s` + 10))
while [[ "$t" -ne `date +%s` ]]; do
    echo -ne "Exiting in.. $(date -u --date @$(($t - `date +%s` )) +%H:%M:%S)\r"
done
exit
