#!/bin/bash

# Executa script de inicialização em background
/usr/local/bin/init-local-config.sh &

# Executa o Apache (processo principal)
echo "Iniciando Apache..."
exec apache2-foreground 