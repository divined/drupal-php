FROM wodby/drupal-php:7.1

USER root

RUN set -ex; \
    \
    git clone https://github.com/longxinH/xhprof; \
    \
    apk add --no-cache \
    php7-dev \
    php7-pear \
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
    docker-php-ext-install xml; \
    \
    docker-php-ext-enable \
    xml \
    xhprof; \
    \
    apk del --purge php7-dev autoconf make gcc g++ re2c file

USER www-data
