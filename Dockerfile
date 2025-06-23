FROM mautic/mautic:5-apache

# Instala o Composer (se não vier no container)
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Instala o bridge do Amazon SES para Symfony Mailer
RUN composer require symfony/amazon-mailer

# Variáveis de ambiente
ARG MAUTIC_DB_HOST
ARG MAUTIC_DB_PORT
ARG MAUTIC_DB_USER
ARG MAUTIC_DB_PASSWORD
ARG MAUTIC_DB_NAME
ARG MAUTIC_URL
ARG MAUTIC_ADMIN_EMAIL
ARG MAUTIC_ADMIN_PASSWORD

ENV MAUTIC_DB_HOST=$MAUTIC_DB_HOST
ENV MAUTIC_DB_PORT=$MAUTIC_DB_PORT
ENV MAUTIC_DB_USER=$MAUTIC_DB_USER
ENV MAUTIC_DB_PASSWORD=$MAUTIC_DB_PASSWORD
ENV MAUTIC_DB_NAME=$MAUTIC_DB_NAME
ENV MAUTIC_URL=$MAUTIC_URL
ENV MAUTIC_ADMIN_EMAIL=$MAUTIC_ADMIN_EMAIL
ENV MAUTIC_ADMIN_PASSWORD=$MAUTIC_ADMIN_PASSWORD
ENV MAUTIC_RUN_CRON_JOBS=true
ENV MAUTIC_TRUSTED_PROXIES=["0.0.0.0/0"]
ENV PHP_INI_DATE_TIMEZONE='UTC'

# Copia configuração inicial do Mautic
COPY --chown=www-data:www-data local.php /var/www/html/app/config/local.php
COPY --chown=www-data:www-data local.php /var/www/html/docroot/app/config/local.php

# Ajustes de permissões e Apache
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN chown -R www-data:www-data /var/www/html/var

# Entrypoint
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
