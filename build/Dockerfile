FROM alpine:edge

RUN apk add --no-cache libcrypto1.1 libssl1.1 libstdc++ --repository http://dl-cdn.alpinelinux.org/alpine/edge/main
RUN apk add tinyproxy
# openconnect and sslh are not yet available on main
RUN apk add --no-cache openconnect --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing
RUN apk add sslh --repository=http://dl-cdn.alpinelinux.org/alpine/edge/testing
RUN apk add openssh
RUN apk add openrc
RUN rc-update add sshd

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 7777

ENTRYPOINT ["/entrypoint.sh"]
