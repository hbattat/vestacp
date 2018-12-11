FROM debian
COPY vst-install.sh /vst-install.sh
COPY vst-install-debian.sh /vst-install-debian.sh
COPY vestacp-redirect.tpl /vestacp-redirect.tpl
COPY vestacp-redirect.stpl /vestacp-redirect.stpl
CMD ["/vst-install.sh"]

ENV HOSTNAME=example.com \
    ADMIN_EMAIL=admin@example.com \
    ADMIN_PASSWORD=changeme

VOLUME ["/vesta", "/home", "/backup"]

EXPOSE 20:20 21:21 2222:22 25:25 53:53 53:53/udp 993:993 54:54 80:80 443:443 110:110 123:123 143:143 3306:3306 5432:5432 8080:8080 8433:8433 8083:8083 12000-12100


