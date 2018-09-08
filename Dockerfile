FROM wodby/drupal-php:7.1

USER root

ENV PHP_URL="https://secure.php.net/get/php-7.1.13.tar.xz/from/this/mirror"

ENV CURL_VERSION 7.50.1

RUN set -ex; \
    mkdir -p /usr/src; \
    cd /usr/src; \
    wget -O php.tar.xz "$PHP_URL"; \
    apk add --update --no-cache gmp gmp-dev && docker-php-ext-install gmp; \
    apk add --update --no-cache openssl openssl-dev nghttp2-dev ca-certificates; \
    apk add --update --no-cache --virtual curldeps g++ make perl; \
    wget https://curl.haxx.se/download/curl-$CURL_VERSION.tar.bz2; \
    tar xjvf curl-$CURL_VERSION.tar.bz2; \
    rm curl-$CURL_VERSION.tar.bz2; \
    cd curl-$CURL_VERSION; \
    ./configure \
        --with-nghttp2=/usr \
        --prefix=/usr \
        --with-ssl \
        --enable-ipv6 \
        --enable-unix-sockets \
        --without-libidn \
        --disable-static \
        --disable-ldap \
        --with-pic; \
    make; \
    make install; \
    cd /; \
    rm -r /var/cache/apk; \
    rm -r /usr/share/man; \
    apk del curldeps

USER wodby
