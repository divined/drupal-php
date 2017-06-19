FROM: wodby/drupal-php:5.6

RUN apk add --no-cache autoconf make gcc g++ re2c file && \
    pecl install -f xhprof-beta && \
    docker-php-ext-enable xhprof && \
    apk del --purge autoconf make gcc g++ re2c file
