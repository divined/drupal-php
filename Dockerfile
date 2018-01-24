FROM wodby/drupal-php:7.1

USER root

RUN set -ex; \
    \
    apk add --update --no-cache --virtual .build-deps \
        autoconf \
        cmake \
        build-base \
        bzip2-dev \
        freetype-dev \
        geoip-dev \
        icu-dev \
        imagemagick-dev \
        imap-dev \
        jpeg-dev \
        libjpeg-turbo-dev \
        libmemcached-dev \
        libmcrypt-dev \
        libpng-dev \
        libtool \
        libxslt-dev \
        openldap-dev \
        pcre-dev \
        postgresql-dev \
        rabbitmq-c-dev \
        php7-dev \
        yaml-dev; \
    \
    git clone https://github.com/longxinH/xhprof; \
    \
    cd xhprof/extension; \
    \
    phpize; \
    \
    ./configure; \
    \
    sudo make && sudo make install; \
    \
    docker-php-source extract; \
    \
    docker-php-ext-install xml; \
    \
    docker-php-ext-enable \
    xhprof \
    xml; \
    \
    apk del --purge php7-dev autoconf make gcc g++ re2c file

USER www-data
