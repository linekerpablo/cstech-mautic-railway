#!/bin/bash

CONFIG_PATH="/var/www/html/app/config/local.php"

echo "🛡️ Verificando instalação do Mautic..."

# Protege banco de dados: NÃO roda instalação automática mesmo que o local.php esteja ausente
if [ ! -f "$CONFIG_PATH" ]; then
  echo "⚠️ Arquivo local.php não encontrado."
  echo "❌ Instalação automática bloqueada para evitar sobrescrever banco existente."
else
  echo "✅ Arquivo local.php encontrado. Mautic já está configurado."
fi

# Sobe Apache normalmente
exec apache2-foreground
