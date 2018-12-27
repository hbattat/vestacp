#!/bin/bash

if [ -f "already_ran" ]; then
    echo "Already ran the Entrypoint once. Holding indefinitely for debugging."
    for i in vesta apache2 nginx bind9 exim4 dovecot clamav-daemon spamassassin mysql cron iptables fail2ban; do service $i restart; done
    cat
fi
touch already_ran


# Vesta installation wrapper
# http://vestacp.com

#
# Currently Supported Operating Systems:
#
#   RHEL 5, 6, 7
#   CentOS 5, 6, 7
#   Debian 7, 8
#   Ubuntu 12.04 - 18.04
#

# Am I root?
if [ "x$(id -u)" != 'x0' ]; then
    echo 'Error: this script can only be executed by root'
    exit 1
fi

# update
apt-get update

# install GnuPG
apt-get -y install gnupg gnupg2 wget

# Check admin user account
if [ ! -z "$(grep ^admin: /etc/passwd)" ] && [ -z "$1" ]; then
    echo "Error: user admin exists"
    echo
    echo 'Please remove admin user before proceeding.'
    echo 'If you want to do it automatically run installer with -f option:'
    echo "Example: bash $0 --force"
    exit 1
fi

# Check admin group
if [ ! -z "$(grep ^admin: /etc/group)" ] && [ -z "$1" ]; then
    echo "Error: group admin exists"
    echo
    echo 'Please remove admin group before proceeding.'
    echo 'If you want to do it automatically run installer with -f option:'
    echo "Example: bash $0 --force"
    exit 1
fi


# Clean up any config
rm -rf /home/*/conf/*/*

# Fix fail2ban
touch /var/log/auth.log

# Install VestaCP
bash vst-install-debian.sh --nginx yes --apache yes --phpfpm no --named yes --remi yes --vsftpd no --proftpd no --iptables yes --fail2ban yes --quota no --exim yes --dovecot yes --spamassassin yes --clamav yes --softaculous no --mysql yes --postgresql no --hostname ${HOSTNAME} --email ${ADMIN_EMAIL} --password ${ADMIN_PASSWORD} -y no


# Copy templates
cp -r /templates/web/nginx/* /usr/local/vesta/data/templates/web/nginx/


# Modify v-change-web-domain-proxy-tpl
sed -i 's/^exit$/\/nodejs_tpl.sh \$1 \$2\nexit/' /usr/local/vesta/bin/v-change-web-domain-proxy-tpl


# Restart nginx
service nginx restart


# Change data dir of mysql
service mysql stop
cp -rn /var/lib/mysql/* /mysql/
rm -rf /var/lib/mysql
ln -s /mysql /var/lib/mysql
chmod -R 777 /mysql
rm -rf /mysql/ib_logfile*
service mysql start


# Install PHP FPM
bash vst-install-php.sh


# Hang
tail -f /dev/null
