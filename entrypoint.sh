#!/bin/bash
cp -f /local.php /var/www/html/app/config/local.php
exec apache2-foreground 