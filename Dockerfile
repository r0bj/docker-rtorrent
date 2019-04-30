FROM alpine:3.9

ARG S6_VER=1.22.1.0
ARG CONFD_VER=0.16.0

# util-linux needed for script command
RUN wget -qP /tmp/ https://github.com/just-containers/s6-overlay/releases/download/v${S6_VER}/s6-overlay-amd64.tar.gz && tar xzf /tmp/s6-overlay-amd64.tar.gz -C / \
  && wget -qO /usr/bin/confd https://github.com/kelseyhightower/confd/releases/download/v${CONFD_VER}/confd-${CONFD_VER}-linux-amd64 && chmod +x /usr/bin/confd \
  && apk add --no-cache openvpn bash screen rtorrent util-linux

COPY etc /etc

ENTRYPOINT ["/init"]
