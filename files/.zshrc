

# -----------------------------------------------------------------------------
#          FILE:  .zshrc
#   DESCRIPTION:  ZSH configuration file.
#        AUTHOR:  Rahul Thakur <rahul.rkt@gmail.com>
#       VERSION:  1.0
# -----------------------------------------------------------------------------


# TERM
export TERM=xterm-color


# PATH
# export PATH=$PATH:/usr/local/bin/composer


# ALIASES
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~"

alias rc="nano ~/.zshrc"
alias omz="nano  ~/.oh-my-zsh"
alias nrc="nano ~/.nanorc"

alias ls="ls -a"
alias python=python3
alias reload="exec $SHELL -l"

alias os-v="lsb_release -a"
alias os-u="do-release-upgrade -d -f DistUpgradeViewNonInteractive"

alias apt-i="apt-get install -y"
alias apt-s="apt-cache search"
alias apt-l="dpkg --get-selections | grep -v deinstall"
alias apt-u='apt-get update; apt-get upgrade -y; apt-get clean; apt-get autoclean -y'

alias comp-i="composer global install"
alias comp-s="composer search"
alias comp-l="composer global show -i"
alias comp-u='composer global self-update; composer global update; composer global clear-cache'

alias npm-i="npm install -g"
alias npm-s="npm search"
alias npm-l="npm ls -g"
alias npm-u='npm install npm -g; npm update -g; npm cache clean'

alias pip-i="pip install"
alias pip-s="pip search"
alias pip-l="pip list"
alias pip-l-o="pip list -o"
alias pip-u='pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U; rm -rf ~/.pip/cache/'

alias gem-i="yes | gem install"
alias gem-s="gem search -r"
alias gem-l="gem search -a -l"
alias gem-u='gem update --system; gem update; gem cleanup'

alias update='do-release-upgrade -d -f DistUpgradeViewNonInteractive; apt-get update; apt-get upgrade -y; apt-get clean; apt-get autoclean -y; composer global self-update; composer global update; composer global clear-cache; npm install npm -g; npm update -g; npm cache clean; pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U; rm -rf ~/.pip/cache/; gem update --system; gem update; gem cleanup'
