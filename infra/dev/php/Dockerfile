FROM monsieurbiz/php:7.2-apache

RUN pecl install redis && \
    docker-php-ext-enable redis

# Install wkhtmltopdf
RUN apt-get update && \
    apt-get install -y \
        fontconfig \
        fontconfig-config \
        fonts-dejavu-core \
        libfontconfig1 \
        libfontenc1 \
        libxfont1 \
        libxrender1 \
        ucf \
        x11-common \
        xfonts-75dpi \
        xfonts-base \
        xfonts-encodings \
        xfonts-utils && \
    wget https://downloads.wkhtmltopdf.org/0.12/0.12.5/wkhtmltox_0.12.5-1.stretch_amd64.deb && \
    dpkg -i wkhtmltox_0.12.5-1.stretch_amd64.deb && \
    rm wkhtmltox_0.12.5-1.stretch_amd64.deb

COPY files/vhost.conf /etc/apache2/sites-enabled/vhost.conf

# Symfony binary
COPY files/bin/console /usr/local/bin/console
RUN chmod a+x /usr/local/bin/console

# Use www-data user
ARG USER_UID=1000
RUN usermod -u $USER_UID www-data

# Add some custom PHP config
COPY files/php.ini /usr/local/etc/php/php.ini