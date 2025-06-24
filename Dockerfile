FROM mautic/mautic:v4-apache

# Variáveis de ambiente (opcional, pode ser só no Railway)
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
ENV PHP_INI_DATE_TIMEZONE='UTC'

# Copia apenas o local.php
COPY local.php /var/www/html/app/config/local.php

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN chown -R www-data:www-data /var/www/html
RUN mkdir -p /var/www/html/var && chown -R www-data:www-data /var/www/html/var

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]

