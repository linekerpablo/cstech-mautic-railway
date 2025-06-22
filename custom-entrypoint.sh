#!/bin/bash

CONFIG_PATH="/var/www/html/app/config/local.php"

if [ ! -f "$CONFIG_PATH" ]; then
  echo "⚠️ Mautic config not found at $CONFIG_PATH"
  echo "⚠️ Preservando banco de dados existente. Instalador NÃO será executado automaticamente."
else
  echo "✅ Mautic já instalado. Arquivo local.php detectado."
fi

# Executa o Apache normalmente
exec apache2-foreground
