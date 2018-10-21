FROM node:8

# Use app user
ARG USER_UID=1000
RUN usermod -u 65533 node
RUN usermod -u $USER_UID www-data

WORKDIR /var/www

USER www-data
