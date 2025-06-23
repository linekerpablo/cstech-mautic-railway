<?php
$parameters = array(
    'db_driver' => 'pdo_mysql',
    'db_host' => getenv('MAUTIC_DB_HOST'),
    'db_port' => getenv('MAUTIC_DB_PORT') ?: '3306',
    'db_name' => getenv('MAUTIC_DB_NAME'),
    'db_user' => getenv('MAUTIC_DB_USER'),
    'db_password' => getenv('MAUTIC_DB_PASSWORD'),
    'site_url' => getenv('MAUTIC_URL'),
    'trusted_proxies' => getenv('MAUTIC_TRUSTED_PROXIES'),
    'install_source' => 'Docker',
    'installed' => true,
    'secret_key' => 'a984e76e-93e7-43e9-b4aa-6781d6f6df14'
);