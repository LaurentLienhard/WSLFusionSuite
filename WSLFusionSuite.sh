#!/bin/bash

#Install Backend
apt-get install php7.4-fpm php7.4-mysql php7.4-xml nginx fcgiwrap composer mariadb-server vim openssh-server openssh-client curl -y
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