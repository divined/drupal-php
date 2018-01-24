FROM wodby/drupal-php:7.1

USER root

ENV PHP_URL="https://secure.php.net/get/php-7.1.13.tar.xz/from/this/mirror"

RUN set -ex; \
    \
    git clone https://github.com/longxinH/xhprof; \
    \
    apk add --no-cache \
    php7-dev \
    php7-xml \
    autoconf \
    make \
    gcc \
    g++ \
    re2c \
    file; \
    \
    cd xhprof/extension; \
    \
    phpize; \
    \
    ./configure; \
    \
    sudo make && sudo make install; \
    \
    mkdir -p /usr/src; \
    cd /usr/src; \
    \
    wget -O php.tar.xz "$PHP_URL"; \
    \
    docker-php-ext-install \
    simplexml \
    xml; \
    \
    docker-php-ext-enable \
    simplexml \
    xml \
    xhprof; \
    \
    apk del --purge \
    php7-dev \
    php7-xml \
    autoconf \
    make \
    gcc \
    g++ \
    re2c \
    file

USER www-data
