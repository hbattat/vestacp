# Dockorized VestaCP

[VestaCP](https://vestacp.com) is a great control panel for hosting sites and web apps. This image is the latest version of Vesta CP with an update version of PHP (the official installation comes with PHP 7.0 at the time of this writing)

# Features
- Small size less than **45 MB**
- Debian 9
- Multiple versions of PHP, different sites can run different version:
  - PHP 5.6
  - PHP 7.0
  - PHP 7.1
  - PHP 7.2
- Full Vesta CP features (nginx, apache, fail2ban, exim, dovecot, spamassassin, clamav, and mysql)
- No FTP (for security reasons. Use SFTP)
- Force HTTPS proxy template to force site(s) to redirect to https://
- Valid SSL cert for vesta CP (https://url:8083)
- Restarting the container restarts vesta services
- Persistent volumes to save user data, MYSQL and backups on the host machine


# How to run
You can execute `./docker.sh` which will pull the image and run it for you or:

Create volume directories:
```
mkdir -p /root/docker_vols/vestacp/{mysql,home,backup}
```

Then pull the image:
```
docker pull hbattat/vestacp
```

Finally run it with your desired configuration:
```
docker run -p 2222:22 -p 80:80 -p 443:443 -p 8083:8083 \
-v /root/docker_vols/vestacp/mysql:/mysql \
-v /root/docker_vols/vestacp/home:/home \
-v /root/docker_vols/vestacp/backup:/backup \
--cap-add=NET_ADMIN --cap-add=NET_RAW \
-e "HOSTNAME=example.com" \
-e "ADMIN_EMAIL=example@email.com" \
-e "ADMIN_PASSWORD=changeme" \
-dit --name vestacp hbattat/vestacp
```
