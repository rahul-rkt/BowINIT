#!/bin/bash
# -----------------------------------------------------------------------------
#          FILE:  update.sh
#   DESCRIPTION:  Update Ubuntu to 14.10, install Nano, switch to ZSH.
#        AUTHOR:  Rahul Thakur <rahul.rkt@gmail.com>
#       VERSION:  1.0
# -----------------------------------------------------------------------------


pgrep -P $(echo $$) > $pid


# Intro
if [[ "666$(dpkg --get-selections | grep -v deinstall | grep figlet)" == "666" ]]; then
    apt-get install -y figlet > /dev/null 2>&1
fi
echo -e "\e[1;93m$(figlet BowINIT)\e[0;0m" >> $log 2> /dev/null
echo -e "BowINIT \e[2;93mby Rahul Thakur\e[0;0m, is trying to setup your Bowery environment. Save and restart when prompted..\n\n" >> $log
t=$((`date +%s` + 3))
while [[ "$t" != `date +%s` ]]; do
    echo -ne "Starting in.. $(date -u --date @$(($t - `date +%s` )) +%H:%M:%S)\r" >> $log
done


# Install script dependencies
apt-get update >> $log 2>&1
apt-get install -y gsfonts jq language-pack-en language-pack-en-base language-pack-gnome-en language-pack-gnome-en-base language-selector-common make update-manager-core >> $log 2>&1


# Update Ubuntu to Utopic Unicorn
if [[ "$(lsb_release -r | cut -f2)" != "14.10" ]]; then
    echo -e "\n\n\e[1;94mAttempting to update to Ubuntu 14.10 Utopic Unicorn. It will take few minutes to complete, hold on.\n\nRELEASE INFO ---------------------\n$(lsb_release -d -r -c)\n----------------------------------\e[0;0m\n\n" >> $log
    sed -i 's/Prompt=lts/Prompt=normal/g' /etc/update-manager/release-upgrades
    do-release-upgrade -d -f DistUpgradeViewNonInteractive >> $log 2>&1
    sed -i 's/Prompt=normal/Prompt=lts/g' /etc/update-manager/release-upgrades
else
    echo -e "\n\n\e[1;92m\n\nYou are already running Ubuntu 14.10 Utopic Unicorn.\e[0;0m\n\n" >> $log
fi


# Install and configure Nano
if [[ $(jq .opt.nano $config) == true ]]; then
    apt-get install -y nano >> $log 2>&1
    git clone git://github.com/nanorc/nanorc.git >> $log 2>&1
    cd nanorc
    make install >> $log 2>&1
    cd ..
    rm -rf nanorc
    cat $dir/files/.nanorc > ~/.nanorc
fi


# Install and configure ZSH
if [[ $(jq .opt.zsh $config) == true ]]; then
    apt-get install -y zsh >> $log 2>&1
    curl -L https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sh >> $log 2>&1
    cat $dir/files/.zshrc >> ~/.zshrc
    git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting >> $log 2>&1
    sed -i 's/plugins=(git)/plugins=(git zsh-syntax-highlighting)/g' ~/.zshrc
    chsh -s /bin/zsh $USER >> $log 2>&1
    rc=~/.zshrc
    sed -i '/rc=/d' $vars
    echo -e "export rc=$rc" >> $vars
fi


# Fix RC
lang="$(jq .opt.lang $config -r)"
if [[ "666$lang" == "666" || "$lang" == "null" ]]; then
    lang="C.UTF-8"
fi
langfix="\n\n# UTF-8 FIX\nexport LANG=$lang\nexport LANGUAGE=$lang\nexport LC_ALL=$lang"
tz="$(jq .opt.timezone $config -r)"
if [[ "666$tz" == "666" || "$tz" == "null" ]]; then
    tz="UTC"
fi
tzfix="\n\n# TIMEZONE\nexport TZ=$tz"
stager=1
sed -i '/stager=/d' $vars
echo -e "export stager=$stager" >> $vars
echo -e "$langfix\n$tzfix\n\nsource $vars" >> $rc


# Exit
echo -e "\n\n\e[1;92mYour Bowery environment has been updated. It's safe to save and restart your environment now.\n\nRELEASE INFO ---------------------\n$(lsb_release -d -r -c)\n----------------------------------\e[0;0m\n\n" >> $log
t=$((`date +%s` + 10))
while [[ "$t" != `date +%s` ]]; do
    echo -ne "Exiting in.. $(date -u --date @$(($t - `date +%s` )) +%H:%M:%S)\r" >> $log
done
exit $?
