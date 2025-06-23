#!/bin/bash
chown -R www-data:www-data /var/www/html/var
exec apache2-foreground 