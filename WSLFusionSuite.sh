#!/bin/bash

#Install Backend
apt-get install php7.4-fpm php7.4-mysql php7.4-xml nginx fcgiwrap composer mariadb-server vim openssh-server openssh-client curl -y
mkdir -p /var/www/fusionsuite

git clone https://github.com/fusionSuite/backend.git  /var/www/fusionsuite/backend
git clone https://github.com/fusionSuite/frontend.git /var/www/fusionsuite/frontend
