# Guia de Deploy do Mautic 5 no Railway

## 1. Pré-requisitos
- Conta no Railway
- Banco de dados MySQL/MariaDB (pode ser provisionado pelo Railway)
- Repositório com os arquivos do Mautic e Dockerfile

---

## 2. Estrutura Recomendada dos Arquivos

### Dockerfile (template)
```dockerfile
FROM mautic/mautic:5-apache

# Variáveis de ambiente para o build e runtime
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

# Copia a configuração fixa do Mautic já instalado
COPY --chown=www-data:www-data local.php /var/www/html/app/config/local.php
COPY --chown=www-data:www-data local.php /var/www/html/docroot/app/config/local.php

RUN echo "ServerName localhost" >> /etc/apache2/apache2.conf
RUN chown -R www-data:www-data /var/www/html/var

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]
```

---

### entrypoint.sh (template)
```sh
#!/bin/bash
chown -R www-data:www-data /var/www/html/var
exec apache2-foreground
```

---

### .dockerignore (template)
```dockerignore
.git
.gitignore
README.md
Dockerfile
entrypoint.sh
local.php
local2.php
```

---

### local.php (exemplo)
```php
<?php
$parameters = array(
    'db_driver' => 'pdo_mysql',
    'db_host' => 'mysql.railway.internal',
    'db_port' => '3306',
    'db_name' => 'railway',
    'db_user' => 'root',
    'db_password' => 'SENHA_AQUI',
    'site_url' => 'https://SEU_DOMINIO',
    'trusted_proxies' => ['0.0.0.0/0'],
    'install_source' => 'Docker',
    'installed' => true,
    'secret_key' => 'SUA_SECRET_KEY_AQUI'
);
```

---

## 3. Variáveis de Ambiente no Railway
No painel do Railway, adicione as seguintes variáveis (ajuste conforme seu ambiente):

- MAUTIC_DB_NAME
- MAUTIC_DB_HOST
- MAUTIC_DB_PORT
- MAUTIC_DB_PASSWORD
- MAUTIC_DB_USER
- MAUTIC_RUN_CRON_JOBS
- MAUTIC_ADMIN_EMAIL
- MAUTIC_ADMIN_PASSWORD
- MAUTIC_TRUSTED_PROXIES

**Exemplo para MAUTIC_TRUSTED_PROXIES:**
```
["0.0.0.0/0"]
```

> **Importante:** O valor deve ser um array JSON puro, sem aspas externas.

---

## 4. Problemas comuns com trusted proxies
- **Erro de JSON:** Se o valor de `MAUTIC_TRUSTED_PROXIES` não for um array JSON puro, o Mautic/Symfony apresentará erro de JSON.
- **Formato correto:**
  - No Railway: `["0.0.0.0/0"]`
  - No local.php: `['0.0.0.0/0']`
- **Nunca use:**
  - `'["0.0.0.0/0"]'` (com aspas externas)
  - `0.0.0.0/0` (simples)

Se o erro persistir, remova a variável do painel e deixe apenas no local.php.

---

## 5. Persistência de dados
- No Railway, crie um volume e monte em `/var/www/html/var` para persistir cache, uploads e arquivos temporários do Mautic.
- O banco de dados deve ser externo/persistente (ex: Railway MySQL).

---

## 6. Passos para restaurar ou migrar
1. Suba o projeto no Railway.
2. Configure as variáveis de ambiente conforme acima.
3. Garanta que o volume está montado em `/var/www/html/var`.
4. O arquivo `local.php` deve estar completo e atualizado.
5. Faça o deploy e acesse o domínio configurado.

---

## 7. Observações finais
- Sempre que mudar configurações no Mautic, baixe o novo `local.php` e atualize no repositório.
- Se aparecer erro de trusted proxies, revise o formato da variável no painel do Railway.
- Para dúvidas, consulte a [documentação oficial do Mautic Docker](https://github.com/mautic/docker-mautic) e a [issue sobre trusted proxies](https://github.com/mautic/mautic/issues/13261). 