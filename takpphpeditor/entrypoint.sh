#!/bin/bash
echo "Initializing TAKP Php Editor..."

echo "Sourcing php admin user table"
mysql -h${DB_HOST} -u${DB_USER} -p${DB_PASSWORD} ${DB_NAME} < /var/www/html/sql/schema.sql

# Now start Apache
apache2-foreground
