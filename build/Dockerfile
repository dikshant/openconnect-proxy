FROM alpine:edge

RUN apk add tinyproxy
# openconnect and sslh are not yet available on main
RUN apk add --no-cache openconnect --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing

COPY entrypoint.sh /entrypoint.sh
COPY tinyproxy.conf /etc/tinyproxy/tinyproxy.conf

RUN chmod +x /entrypoint.sh

EXPOSE 8888
ENTRYPOINT ["/entrypoint.sh"]

