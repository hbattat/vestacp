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
- Dynamic NodeJs template that can be used to proxy requests to any internal/external Node app (see below)
- Force HTTPS proxy template to force site(s) to redirect to https://
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

# How to configure NodeJs template
Add an extension to the proxy extensions list in this format nodejs_<host>_<port>

Examples:
nodejs_localhost_3000

```
nodejs_localhost_3000, jpeg, jpg, png, gif, bmp, ico, svg, tif, tiff, css, js, htm, html, ttf, otf, webp, woff, txt, csv, rtf, doc, docx, xls, xlsx, ppt, pptx, odf, odp, ods, odt, pdf, psd, ai, eot, eps, ps, zip, tar, tgz, gz, rar, bz2, 7z, aac, m4a, mp3, mp4, ogg, wav, wma, 3gp, avi, flv, m4v, mkv, mov, mpeg, mpg, wmv, exe, iso, dmg, swf
```

Then change the proxy template to nodejs (or nodejs-force-https if you have an SSL cert and want all the traffic to be redirected to https)

For more details about this template see [this blog post](https://curlybrac.es/2018/12/16/vestacp-nginx-template/)
