#!/bin/bash

#Install Backend
apt-get install php7.4-fpm php7.4-mysql php7.4-xml nginx fcgiwrap composer mariadb-server vim nodejs openssh-server openssh-client curl -y
mkdir -p /var/www/fusionsuite

git clone https://github.com/fusionSuite/backend.git  /var/www/fusionsuite/backend
git clone https://github.com/fusionSuite/frontend.git /var/www/fusionsuite/frontend

rm /etc/nginx/sites-enabled/default
service mariadb start
# Allow SSH Root Login
sed -i 's|^#PermitRootLogin.*|PermitRootLogin yes|g' /etc/ssh/sshd_config
echo "root:root123" | chpasswd

cp ./Sources/fusionsuite.conf /etc/nginx/sites-enabled/fusionsuite.conf
cp ./Sources/phinx.php /var/www/fusionsuite/backend

service php7.4-fpm start
service nginx start
mysql -uroot -proot123 < ./Sources/configure-mariadb.sql

cd /var/www/fusionsuite/backend
composer install
./vendor/bin/phinx migrate

cd /var/www/fusionsuite/frontend
curl -fsSL https://deb.nodesource.com/setup_current.x | bash - \
curl -o- -L https://yarnpkg.com/install.sh | bash \
$HOME/.yarn/bin/yarn install
./node_modules/.bin/ionic build --prod -- --aot=true --buildOptimizer=true --optimization=true --vendor-chunk=true

cp ./Sources/config.json /var/www/fusionsuite/frontend/www/
service nginx restart