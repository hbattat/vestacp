export VESTA=/usr/local/vesta/
user=$1
domain=$2
nodejs_hostname=`/usr/local/vesta/bin/v-list-web-domain $user $domain | grep "PROXY EXT" | sed -r 's/.*nodejs_(.*)_([0-9]+).*/\1/g'`
port_num=`/usr/local/vesta/bin/v-list-web-domain $user $domain | grep "PROXY EXT" | sed -r 's/.*nodejs_(.*)_([0-9]+).*/\2/g'`

sed -i "s/NODEJS_HOSTNAME:65535/$nodejs_hostname:$port_num/g" /home/$user/conf/web/$domain.*
