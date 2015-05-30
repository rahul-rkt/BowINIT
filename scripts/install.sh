#!/bin/bash
# -----------------------------------------------------------------------------
#          FILE:  install.sh
#   DESCRIPTION:  Install all required packages.
#        AUTHOR:  Rahul Thakur <rahul.rkt@gmail.com>
#       VERSION:  1.0
# -----------------------------------------------------------------------------


# Prelude
sed -i 's/exit 101/exit 0/g' /usr/sbin/policy-rc.d
if [[ $(jq .db.use $dir/config.json -r) == "mysql" ]]; then
    echo "mysql-server mysql-server/root_password password $(jq .db.mysql.rootPassword $dir/config.json -r)" | debconf-set-selections
    echo "mysql-server mysql-server/root_password_again password $(jq .db.mysql.rootPassword $dir/config.json -r)" | debconf-set-selections
fi


# Add Apt repositories
apt-get install -y software-properties-common python-software-properties >> $log 2>&1
apt-add-repository -y ppa:ondrej/php5-5.6 >> $log 2>&1
apt-add-repository -y ppa:nginx/stable >> $log 2>&1
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449 >> $log 2>&1
add-apt-repository -y 'deb http://dl.hhvm.com/ubuntu utopic main' >> $log 2>&1
wget -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - >> $log 2>&1
add-apt-repository -y 'deb http://apt.postgresql.org/pub/repos/apt/ utopic-pgdg main' >> $log 2>&1
wget -O - https://packagecloud.io/gpg.key | apt-key add - >> $log 2>&1
add-apt-repository -y 'deb http://packages.blackfire.io/debian any main' >> $log 2>&1
apt-get update >> $log 2>&1


# Install Apt packages
apt-get install -y apt apt-transport-https apt-utils aptitude aptitude-common aptitude-doc-en autoconf automake autotools-dev base-files base-passwd bash bash-completion beanstalkd blackfire-agent blackfire-php build-essential bzip2 ca-certificates command-not-found command-not-found-data console-setup coreutils cpio cpp cpp-4.9 curl dash debconf debconf-i18n debconf-utils debhelper debianutils diffutils dpkg dpkg-dev g++ g++-4.9 gcc gcc-4.9 gcc-4.9-base:amd64 gir1.2-glib-2.0 git git-core git-man gzip hhvm krb5-locales less libcurl4-gnutls-dev libdbus-glib-1-2 libffi-dev libgirepository-1.0-1 libglib2.0-0 libglib2.0-data libgnutls-dev libxml2-dev make makedev memcached mysql-client-5.6 mysql-client-core-5.6 mysql-common mysql-common-5.6 mysql-server-5.6 mysql-server-core-5.6 nginx nginx-common nginx-full nodejs npm openssh-client openssh-server openssh-sftp-server openssl perl perl-base perl-modules pgdg-keyring php-pear php5 php5-apcu php5-cli php5-common php5-curl php5-dev php5-fpm php5-gd php5-gmp php5-imap php5-json php5-mcrypt php5-memcached php5-mysqlnd php5-pgsql php5-readline php5-sqlite php5-xdebug pkg-php-tools postgresql-9.4 postgresql-client-9.4 postgresql-client-common postgresql-common postgresql-contrib-9.4 python python-apt python-apt-common python-chardet python-colorama python-distlib python-html5lib python-meld3 python-minimal python-pip python-pkg-resources python-pycurl python-requests python-setuptools python-six python-urllib3 python-wheel python2.7 python2.7-dev python2.7-minimal python3 python3-apt python3-commandnotfound python3-dbus python3-distupgrade python3-gdbm:amd64 python3-gi python3-minimal python3-pycurl python3-software-properties python3-update-manager python3.4 python3.4-minimal shared-mime-info sgml-base sqlite3 ssh-import-id ssl-cert strace systemd systemd-shim unattended-upgrades ubuntu-keyring ubuntu-minimal ubuntu-release-upgrader-core unzip vim vim-common vim-runtime vim-tiny wget whiptail whois xdg-user-dirs xml-core xz-utils >> $log 2>&1
apt-get upgrade -y >> $log 2>&1
apt-get clean >> $log 2>&1
apt-get autoclean -y >> $log 2>&1
apt-get autoremove -y >> $log 2>&1


# Install Composer and packages
curl -sS https://getcomposer.org/installer | php >> $log 2>&1
mv composer.phar /usr/local/bin/composer
composer global require danielstjules/stringy doctrine/inflector illuminate/contracts illuminate/support laravel/envoy nategood/httpful symfony/console symfony/process >> $log 2>&1
composer global clear-cache >> $log 2>&1


# Install Node packages
npm install -g bower >> $log 2>&1
npm install -g grunt >> $log 2>&1
npm install -g gulp >> $log 2>&1
npm cache clean >> $log 2>&1


# Install Python packages
pip install argparse chardet colorama html5lib meld3 pip requests setuptools six ssh-import-id supervisor urllib3 wheel wsgiref --upgrade --ignore-installed >> $log 2>&1
pip freeze --local | grep -v '^\-e' | cut -d = -f 1  | xargs -n1 pip install -U >> $log 2>&1
rm -rf ~/.pip/cache/


# Install Redis
wget http://download.redis.io/releases/redis-3.0.1.tar.gz >> $log 2>&1
tar -xvzf redis-3.0.1.tar.gz >> $log 2>&1
cd redis-3.0.1
make >> $log 2>&1
cd ..
rm -rf redis-3.0.1
rm -rf redis-3.0.1.tar.gz


# Install Ruby and packages
wget http://cache.ruby-lang.org/pub/ruby/2.2/ruby-2.2.2.tar.xz >> $log 2>&1
tar -xvJf ruby-2.2.2.tar.xz >> $log 2>&1
cd ruby-2.2.2
./configure >> $log 2>&1
make >> $log 2>&1
make install >> $log 2>&1
cd ..
rm -rf ruby-2.2.2
rm -rf ruby-2.2.2.tar.xz
yes | gem install bigdecimal blankslate bundler celluloid CFPropertyList chronic classifier-reborn coffee-script coffee-script-source colorator colortail execjs fast-stemmer ffi file-tail hitimes io-console json kramdown libxml-ruby liquid listen mercenary mini_portile minitest papertrail parslet posix-spawn power_assert psych pygments.rb rake rb-fsevent rb-inotify rdoc redcarpet rubygems-update safe_yaml sass sqlite3 test-unit timers tins titlecase toml yajl-ruby >> $log 2>&1
gem update >> $log 2>&1
gem cleanup >> $log 2>&1


# Exit
clear
sed -i 's/exit 0/exit 101/g' /usr/sbin/policy-rc.d
sed -i 's/stager=1/stager=2/g' "$rc"
echo -e "\n\n\e[1;92mAll dependencies have been installed. It's safe to save and restart your environment now.\e[0;0m\n\n" >> $log
t=$((`date +%s` + 10))
while [[ "$t" -ne `date +%s` ]]; do
echo -ne "Exiting in.. $(date -u --date @$(($t - `date +%s` )) +%H:%M:%S)\r" >> $log
done
exit $?
