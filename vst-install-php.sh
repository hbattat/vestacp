#!/bin/bash

mkdir -p /run/php
apt-get update
apt install apt-transport-https ca-certificates
wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg
sh -c 'echo "deb https://packages.sury.org/php/ stretch main" > /etc/apt/sources.list.d/php.list'
apt-get update
a2enmod proxy_fcgi setenvif

apt-get install php5.6-apcu php5.6-mbstring php5.6-bcmath php5.6-cli php5.6-curl php5.6-fpm php5.6-gd php5.6-intl php5.6-mcrypt php5.6-mysql php5.6-soap php5.6-xml php5.6-zip php5.6-memcache php5.6-memcached php5.6-zip
update-rc.d php5.6-fpm defaults
a2enconf php5.6-fpm
systemctl restart apache2
cp -r /etc/php/5.6/ /root/vst_install_backups/php5.6/
rm -f /etc/php/5.6/fpm/pool.d/*
cp -r /templates/web/apache2/PHP-FPM-56*  /usr/local/vesta/data/templates/web/apache2/
chmod a+x /usr/local/vesta/data/templates/web/apache2/PHP-FPM-56.sh


apt-get install php7.0-apcu php7.0-mbstring php7.0-bcmath php7.0-cli php7.0-curl php7.0-fpm php7.0-gd php7.0-intl php7.0-mcrypt php7.0-mysql php7.0-soap php7.0-xml php7.0-zip php7.0-memcache php7.0-memcached php7.0-zip
update-rc.d php7.0-fpm defaults
a2enconf php7.0-fpm
systemctl restart apache2
cp -r /etc/php/7.0/ /root/vst_install_backups/php7.0/
rm -f /etc/php/7.0/fpm/pool.d/*
cp -r /templates/web/apache2/PHP-FPM-70*  /usr/local/vesta/data/templates/web/apache2/
chmod a+x /usr/local/vesta/data/templates/web/apache2/PHP-FPM-70.sh


apt-get install php7.1-apcu php7.1-mbstring php7.1-bcmath php7.1-cli php7.1-curl php7.1-fpm php7.1-gd php7.1-intl php7.1-mcrypt php7.1-mysql php7.1-soap php7.1-xml php7.1-zip php7.1-memcache php7.1-memcached php7.1-zip
update-rc.d php7.1-fpm defaults
a2enconf php7.1-fpm
systemctl restart apache2
cp -r /etc/php/7.1/ /root/vst_install_backups/php7.1/
rm -f /etc/php/7.1/fpm/pool.d/*
cp -r /templates/web/apache2/PHP-FPM-71*  /usr/local/vesta/data/templates/web/apache2/
chmod a+x /usr/local/vesta/data/templates/web/apache2/PHP-FPM-71.sh


apt-get install php7.2-apcu php7.2-mbstring php7.2-bcmath php7.2-cli php7.2-curl php7.2-fpm php7.2-gd php7.2-intl php7.2-mysql php7.2-soap php7.2-xml php7.2-zip php7.2-memcache php7.2-memcached php7.2-zip
update-rc.d php7.2-fpm defaults
a2enconf php7.2-fpm
systemctl restart apache2
cp -r /etc/php/7.2/ /root/vst_install_backups/php7.2/
rm -f /etc/php/7.2/fpm/pool.d/*
cp -r /templates/web/apache2/PHP-FPM-72*  /usr/local/vesta/data/templates/web/apache2/
chmod a+x /usr/local/vesta/data/templates/web/apache2/PHP-FPM-72.sh

service apache2 restart && service nginx restart
