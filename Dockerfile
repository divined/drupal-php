FROM wodby/drupal-php:7.1

USER root

RUN set -ex; \
    \
    git clone https://github.com/longxinH/xhprof; \
    \
    apk add --no-cache php7-dev autoconf make gcc g++ re2c file; \
    \
    cd xhprof/extension; \
    \
    phpize; \
    \
    ./configure --with-php-config=/usr/bin/php-config7.1; \
    \
    sudo make && sudo make install
