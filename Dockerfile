FROM alpine:3.7

ARG S6_VER=1.21.4.0
ARG CONFD_VER=0.16.0

RUN wget -P /tmp/ https://github.com/just-containers/s6-overlay/releases/download/v${S6_VER}/s6-overlay-amd64.tar.gz && tar xzf /tmp/s6-overlay-amd64.tar.gz -C /

RUN wget -qO /usr/bin/confd https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VER}/confd-${CONFD_VER}-linux-amd64 && chmod +x /usr/bin/confd
COPY iptables.rules.toml /etc/confd/conf.d/
COPY iptables.rules.tmpl /etc/confd/templates/

COPY 01-confd 02-tun-device 03-iptables-restore 04-user /etc/cont-init.d/

# util-linux needed for script command
RUN apk add --no-cache openvpn bash screen rtorrent util-linux

RUN mkdir /etc/services.d/ovpn
COPY ovpn-run /etc/services.d/ovpn/run

COPY rtorrent.rc /.rtorrent.rc

RUN mkdir /etc/services.d/rtorrent
COPY rtorrent-run /etc/services.d/rtorrent/run

ENTRYPOINT ["/init"]
