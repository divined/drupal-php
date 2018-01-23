FROM wodby/drupal-php:7.1

USER root

RUN set -ex; \
    \
    git clone https://github.com/longxinH/xhprof; \
    \
    cd xhprof/extension; \
    \
    phpize; \
    \
    ./configure --with-php-config=/usr/bin/php-config7.0; \
    \
    sudo make && sudo make install
