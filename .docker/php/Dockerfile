FROM php:8.2-fpm AS php_base
WORKDIR "/application"

# Install selected extensions and other stuff
RUN apt-get update && apt-get install -y \
    git \
    zlib1g-dev libpng-dev libjpeg-dev libmcrypt-dev libfreetype6-dev \
    unzip

# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN composer --version

# Install NPM
RUN curl -sL https://deb.nodesource.com/setup_20.x | bash
RUN apt-get install nodejs -y
RUN node -v && npm -v

# Remove APT cache
RUN apt-get clean; rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /usr/share/doc/*

# Set timezone
RUN rm /etc/localtime
RUN ln -s /usr/share/zoneinfo/Europe/Warsaw /etc/localtime
RUN "date"

RUN docker-php-ext-install pdo pdo_mysql

RUN docker-php-ext-install iconv \
    && docker-php-ext-configure gd \
        --with-jpeg \
        --with-freetype=/usr/include/freetype2 \
        --with-jpeg=/usr/include \
    && docker-php-ext-install gd \
    && docker-php-ext-enable gd

RUN echo 'alias sf="php bin/console"' >> ~/.bashrc

FROM php_base AS php_test

RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

RUN echo "xdebug.coverage_enable" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
RUN echo "xdebug.mode=coverage" >> /usr/local/etc/php/conf.d/docker-php-ext-xdebug.ini
