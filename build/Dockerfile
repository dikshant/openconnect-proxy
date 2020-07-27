FROM alpine:edge

# openconnect and sslh are not yet available on main
RUN apk add --no-cache openconnect --repository http://dl-cdn.alpinelinux.org/alpine/edge/testing
RUN apk add --no-cache ca-certificates wget \
    && wget -q -O /etc/apk/keys/sgerrand.rsa.pub https://alpine-pkgs.sgerrand.com/sgerrand.rsa.pub \
    && wget https://github.com/sgerrand/alpine-pkg-glibc/releases/download/2.30-r0/glibc-2.30-r0.apk \
    && apk add --no-cache --virtual .build-deps glibc-2.30-r0.apk gcc make musl-dev \
    && cd /tmp \
    && wget https://github.com/rofl0r/microsocks/archive/v1.0.1.tar.gz \
    && tar -xzvf v1.0.1.tar.gz \
    && cd microsocks-1.0.1 \
    && make \
    && make install \
    # always add the docker DNS server
    && apk del .build-deps wget

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

EXPOSE 8888
ENTRYPOINT ["/entrypoint.sh"]

