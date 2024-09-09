# Use the official PHP image as a base image
FROM php:8.0-apache

ENV DB_HOST=host.docker.internal
ENV DB_USER=peq
ENV DB_PASSWORD=peqpass
ENV DB_NAME=peq
ENV DB_PORT=3306


# Install necessary packages including the mysqli extension
RUN apt-get update && apt-get install -y \
    git \
    mariadb-client \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    && docker-php-ext-configure gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd mysqli

# Enable Apache modules (if required)
RUN a2enmod rewrite

# Set up the working directory
WORKDIR /var/www/html

# Clone the project from GitHub into the working directory
RUN git clone https://github.com/EQMacEmu/takpphpeditor.git .
RUN mv config.php.dist config.php

# Configure PHP
RUN echo "short_open_tag = On" >> /usr/local/etc/php/php.ini
RUN echo "error_reporting = E_ALL & ~E_NOTICE & ~E_WARNING" >> /usr/local/etc/php/php.ini

# Set permissions for the web directory
RUN chown -R www-data:www-data /var/www/html

# Expose port 80 to the host
EXPOSE 80

COPY entrypoint.sh /usr/local/bin/
ENTRYPOINT [ "entrypoint.sh" ]

