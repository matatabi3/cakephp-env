#!/bin/bash
cd `dirname $0`

if [ ! -e /var/www/html/cake/vendor ]; then
    cd /var/www/html/cake
    composer install
fi

echo "wait for cake_db start up..."
echo "dockerize -timeout 20s -wait tcp://cake_db:3306"
dockerize -timeout 20s -wait tcp://cake_db:3306

echo "cd /var/www/html/cake/bin"
cd /var/www/html/cake/bin

echo "execute 'php cake.php migrations migrate"
php cake.php migrations migrate

echo "execute 'php cake.php migrations seed"
php cake.php migrations seed

echo "restart apache2 /etc/apache2/envvars && exec /usr/sbin/apache2 -DFOREGROUND"
source /etc/apache2/envvars && exec /usr/sbin/apache2 -DFOREGROUND "$@"
