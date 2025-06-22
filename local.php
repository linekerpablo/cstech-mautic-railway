<?php
$parameters = array(
    'db_driver' => 'pdo_mysql',
    'db_host' => getenv('MAUTIC_DB_HOST'),
    'db_port' => getenv('MAUTIC_DB_PORT'),
    'db_name' => getenv('MAUTIC_DB_NAME'),
    'db_user' => getenv('MAUTIC_DB_USER'),
    'db_password' => getenv('MAUTIC_DB_PASSWORD'),
    'installed' => true,
    'site_url' => getenv('MAUTIC_URL'),
    'secret_key' => 'b84c91f2-1d61-4de4-9a75-75b4d18bd2d8'
);
