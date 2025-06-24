FROM mautic/mautic:v4-apache

# Variáveis de ambiente necessárias para inicialização do Mautic
ENV MAUTIC_DB_HOST=mysql.railway.internal
ENV MAUTIC_DB_PORT=3306
ENV MAUTIC_DB_NAME=railway
ENV MAUTIC_DB_USER=root
ENV MAUTIC_DB_PASSWORD=fvJdZNnmtUuiRzcSdfujydMVRzJjuoQl
ENV MAUTIC_RUN_CRON_JOBS=true
ENV PHP_INI_DATE_TIMEZONE='UTC'

# Copia o local.php
COPY local.php /tmp/local.php

# Configurações básicas do Apache
RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf

# Cria um script de inicialização
RUN echo '#!/bin/bash\n\
# Aguarda diretório ser criado e copia local.php\n\
(\n\
  for i in {1..300}; do\n\
    if [ -d "/var/www/html/app/config" ]; then\n\
      echo "Copiando local.php personalizado..."\n\
      cp /tmp/local.php /var/www/html/app/config/local.php\n\
      chown www-data:www-data /var/www/html/app/config/local.php\n\
      chmod 644 /var/www/html/app/config/local.php\n\
      echo "Configuração aplicada!"\n\
      break\n\
    fi\n\
    sleep 1\n\
  done\n\
) &\n\
exec "$@"' > /usr/local/bin/entrypoint-wrapper.sh \
&& chmod +x /usr/local/bin/entrypoint-wrapper.sh

ENTRYPOINT ["/usr/local/bin/entrypoint-wrapper.sh"]
CMD ["apache2-foreground"]

