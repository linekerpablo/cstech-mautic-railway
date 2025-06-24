FROM mautic/mautic:v4-apache

# Variáveis de ambiente para Railway
ENV MAUTIC_RUN_CRON_JOBS=true
ENV PHP_INI_DATE_TIMEZONE='UTC'

# Copia o local.php e um script de inicialização
COPY local.php /tmp/local.php
COPY init-local-config.sh /usr/local/bin/init-local-config.sh

# Configurações básicas do Apache
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Torna o script executável
RUN chmod +x /usr/local/bin/init-local-config.sh

# Copia e configura nosso entrypoint customizado
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

