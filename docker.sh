#!/bin/bash

mkdir -p /root/docker_vols/vestacp/{mysql,home,backup}

docker pull hbattat/vestacp

docker run -p 2222:22 -p 80:80 -p 443:443 -p 8083:8083 -v /root/docker_vols/vestacp/mysql:/mysql -v /root/docker_vols/vestacp/home:/home -v /root/docker_vols/vestacp/backup:/backup --cap-add=NET_ADMIN --cap-add=NET_RAW -e "HOSTNAME=example.com" -e "ADMIN_EMAIL=example@email.com" -e "ADMIN_PASSWORD=changeme" -dit --name vestacp hbattat/vestacp


echo "To attach run the following command:"
echo "docker container attach vestacp"
echo ""
echo "Press Ctrl + p , Ctrl + q to turn interactive mode to daemon mode to detach"
