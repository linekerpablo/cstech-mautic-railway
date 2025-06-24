# Troubleshooting - Mautic 4 Railway

## Verificações Pós-Deploy

### 1. Verificar se o local.php foi copiado corretamente
```bash
# Conectar no container Railway e verificar:
ls -la /var/www/html/app/config/local.php
cat /var/www/html/app/config/local.php
```

### 2. Verificar logs do container
```bash
# No Railway, verificar os logs para estas mensagens:
# "Aguardando criação do diretório de configuração..."
# "Copiando arquivo de configuração..."
# "Iniciando Apache..."
```

### 3. Verificar conectividade com o banco
```bash
# Dentro do container:
php -r "
$pdo = new PDO('mysql:host=mysql.railway.internal;port=3306;dbname=railway', 'root', 'fvJdZNnmtUuiRzcSdfujydMVRzJjuoQl');
echo 'Conexão OK';
"
```

### 4. Verificar tabelas do Mautic
O banco deve ter tabelas como:
- `leads`
- `users` 
- `campaigns`
- `emails`

### 5. Se ainda aparecer a tela de instalação

Possíveis causas:
1. **Volume não persistindo**: Verificar se o volume `/var/www/html/var` está montado
2. **Arquivo local.php não encontrado**: Verificar se o timing do entrypoint está correto
3. **Permissões incorretas**: Verificar se o arquivo está com permissões 644
4. **Cache**: Limpar cache do browser e tentar novamente

### 6. Debug adicional
Adicionar no entrypoint para debug:
```bash
echo "Conteúdo do diretório config:"
ls -la /var/www/html/app/config/
echo "Conteúdo do local.php:"
cat /var/www/html/app/config/local.php
``` 