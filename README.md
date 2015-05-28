# BowINIT *(under development)*
BowInit is aimed at provisioning a barebones [Bowery](http://bowery.io/) environment for Laravel development. This script is intended to mimic the setup you get with [Vagrant](https://www.vagrantup.com/)/[Homestead](http://laravel.com/docs/5.0/homestead) over Bowery.

><i class="fa fa-exclamation"/> For best results, use this script on a fresh Bowery instance. This script has been tested on Bash and ZSH.


#### USAGE:

##### 1. Clone repository
><i class="fa fa-info"/> This could be done either in your shared Bowery folder or directly from the Bowery environment (if you are comfortable using any cli editor).

```
git clone https://github.com/rahul-rkt/BowINIT.git
```

##### 2. Update configurations
><i class="fa fa-info"/> If you want to use a cli editor other than Vim (like Nano), you have to apt-get install the required package(s).

```
vim BowINIT/config.json
```

##### 3. Run script
><i class="fa fa-info"/> Save and restart your environment when prompted. The script will auto resume after restart.

```
source BowINIT/init.sh
```


#### CONFIGURATIONS:
