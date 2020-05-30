FROM    php:7.2-apache

ARG DOCKER_UID=1000
ARG DOCKER_USER=www-data

RUN     usermod -u ${DOCKER_UID} ${DOCKER_USER} \
    &&  groupmod -g ${DOCKER_UID} ${DOCKER_USER} \
    &&  a2enmod rewrite \
    &&  pecl install xdebug-2.6.0 \
    &&  apt-get update -y \
    &&  apt-get install -y \
        zlib1g-dev \
        libicu-dev \
        libsodium-dev \
        libcurl4-openssl-dev \
        libedit-dev \
        libsodium-dev \
        libsqlite3-dev \
        libssl-dev \
        libxml2-dev \
        zlib1g-dev \
    &&  docker-php-ext-enable xdebug \
    &&  docker-php-ext-install pdo_mysql mysqli mbstring zip sodium intl xml \
    &&  apt-get clean
COPY ./php/docker-php-ext-xdebug.ini /usr/local/etc/php/conf.d/
COPY ./php/date.ini /usr/local/etc/php/conf.d/
COPY ./php/mbstring.ini /usr/local/etc/php/conf.d/
COPY ./apache/*.conf /etc/apache2/sites-enabled/
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN apt-get update && apt-get install -y wget
ENV DOCKERIZE_VERSION v0.6.1
RUN wget https://github.com/jwilder/dockerize/releases/download/$DOCKERIZE_VERSION/dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && tar -C /usr/local/bin -xzvf dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz \
    && rm dockerize-linux-amd64-$DOCKERIZE_VERSION.tar.gz

