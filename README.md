# BowINIT *(under development)*
BowInit is aimed at provisioning a barebones [Bowery](http://bowery.io/) environment for Laravel development. This script is intended to mimic the setup you get with [Vagrant](https://www.vagrantup.com/)/[Homestead](http://laravel.com/docs/5.0/homestead) over Bowery.

:grey_exclamation: For best results, use this script on a fresh Bowery instance. This script has been tested on Bash and ZSH.


## Usage:

##### 1. Clone repository
This could be done either in your shared Bowery folder or directly from the Bowery environment (if you are comfortable using any cli editor).
```
git clone git://github.com/rahul-rkt/BowINIT.git
```

##### 2. Update configurations
If you want to use a cli editor other than Vim (like Nano), you have to apt-get install the required package(s).
```
vi ./BowINIT/config.json
```

##### 3. Source script
Save and restart your environment when prompted. The script will auto resume after restart.
```
// Make sure you are on a sudo shell
sudo -s
source ./BowINIT/init.sh
```


## Configurations:
*will be updated soon..*


## Cleanup:
All temporary data is created inside BowINIT directory, simply rm.
```
rm -rf ./BowINIT
```
