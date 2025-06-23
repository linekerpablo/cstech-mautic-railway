#!/bin/bash
# Aguarda até que o diretório de destino exista
while [ ! -d /var/www/html/app/config ]; do
  sleep 1
done
cp -f /local.php /var/www/html/app/config/local.php
exec apache2-foreground 