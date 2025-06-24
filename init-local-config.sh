#!/bin/bash

echo "[INIT] Aguardando criação do diretório de configuração..."

# Aguarda até 180 segundos pelo diretório
for i in {1..180}; do
    if [ -d "/var/www/html/app/config" ]; then
        echo "[INIT] Diretório encontrado! Copiando local.php..."
        cp /tmp/local.php /var/www/html/app/config/local.php
        chown www-data:www-data /var/www/html/app/config/local.php
        chmod 644 /var/www/html/app/config/local.php
        echo "[INIT] Configuração aplicada com sucesso!"
        exit 0
    fi
    
    # Log de progresso a cada 30 segundos
    if [ $((i % 30)) -eq 0 ]; then
        echo "[INIT] Ainda aguardando... ($i/180 segundos)"
    fi
    
    sleep 1
done

echo "[INIT] ERRO: Timeout aguardando criação do diretório de configuração"
echo "[INIT] Listando /var/www/html:"
ls -la /var/www/html/ 2>/dev/null || echo "[INIT] Diretório não encontrado"
exit 1 