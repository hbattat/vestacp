#!/bin/bash

if [ -f "already_ran" ]; then
    echo "Already ran the Entrypoint once. Holding indefinitely for debugging."
    service vesta start && service nginx restart
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


# Install VestaCP
bash vst-install-debian.sh --nginx yes --apache yes --phpfpm no --named yes --remi yes --vsftpd no --proftpd no --iptables yes --fail2ban yes --quota no --exim yes --dovecot yes --spamassassin yes --clamav yes --softaculous no --mysql yes --postgresql no --hostname ${HOSTNAME} --email ${ADMIN_EMAIL} --password ${ADMIN_PASSWORD} -y no


# Add vestacp redirect template
cp /vestacp-redirect.tpl /usr/local/vesta/data/templates/web/nginx/
cp /vestacp-redirect.stpl /usr/local/vesta/data/templates/web/nginx/

service nginx restart

# Create an SSL and change template for cp domain
#export VESTA=/usr/local/vesta/
#touch /root/.rnd
#/usr/local/vesta/bin/v-add-letsencrypt-user admin
#challenge=`cat /usr/local/vesta/data/users/admin/ssl/le.conf | sed -En "s/THUMB='(.*)'/\1/gp"`
#sed -i -e "s/return 200 \".*\";/return 200 \""'$1'".$challenge\";/g" /home/admin/conf/web/nginx.${HOSTNAME}.conf_letsencrypt
#/usr/local/vesta/bin/v-add-letsencrypt-domain admin ${HOSTNAME}


# Can't apply it due to a bug in vestacp, has to be switched manually
#/usr/local/vesta/bin/v-change-web-domain-proxy-tpl admin ${HOSTNAME} default
#/usr/local/vesta/bin/v-change-web-domain-proxy-tpl admin ${HOSTNAME} vestacp-redirect


# Add force https template
(cd /usr/local/vesta/data/templates/web && wget http://c.vestacp.com/0.9.8/rhel/force-https/nginx.tar.gz && tar -xzvf nginx.tar.gz && rm -f nginx.tar.gz)


# Hang
tail -f /dev/null
