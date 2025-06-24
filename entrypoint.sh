#!/bin/bash

# Aguarda o diretório de configuração ser criado pelo container Mautic
echo "Aguardando criação do diretório de configuração..."
while [ ! -d "/var/www/html/app/config" ]; do
    sleep 1
done

# Copia o arquivo de configuração para o local correto
echo "Copiando arquivo de configuração..."
cp /tmp/local.php /var/www/html/app/config/local.php

# Ajusta permissões
chown -R www-data:www-data /var/www/html
chmod 644 /var/www/html/app/config/local.php

echo "Iniciando Apache..."
exec apache2-foreground 