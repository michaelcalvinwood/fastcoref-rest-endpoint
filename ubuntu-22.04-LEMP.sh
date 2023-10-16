#!/bin/bash

if [ -n "$1" ]; then
  Domain=$1
else
  echo "Enter First parameter: Domain"
  exit
fi

if [ -n "$2" ]; then
  DBPassword=$2
else
  echo "Enter Second parameter: DBPassword"
  exit
fi

if [ -n "$3" ]; then
  EmailAddress=$3
else
  echo "Enter Second parameter: EmailAddress"
  exit
fi

# Install and Configure nginx
sudo DEBIAN_FRONTEND="noninteractive" apt -y --assume-yes update
sudo DEBIAN_FRONTEND="noninteractive" apt -y --assume-yes upgrade
sudo DEBIAN_FRONTEND="noninteractive" apt install -y --assume-yes nginx libnginx-mod-http-headers-more-filter
sudo ufw app list
sudo ufw allow 'Nginx HTTP'

sudo mkdir /var/www/$Domain

sudo chown -R $USER:$USER /var/www/$Domain

printf "server {
    listen 80;
    server_name $Domain www.$Domain;
    root /var/www/$Domain;

    index index.php index.html index.htm;

    location / {
        try_files \$uri \$uri/ =404;
    }

    location ~ \.php$ {
        include snippets/fastcgi-php.conf;
        fastcgi_pass unix:/var/run/php/php8.1-fpm.sock;
        fastcgi_read_timeout 600;
        fastcgi_send_timeout 600;
        fastcgi_connect_timeout 600;
     }

    location ~ /\.ht {
        deny all;
    }

}" > /etc/nginx/sites-available/$Domain

sudo ln -s /etc/nginx/sites-available/$Domain /etc/nginx/sites-enabled/

sudo unlink /etc/nginx/sites-enabled/default

sudo nginx -t

sudo systemctl reload nginx

printf "<html>
  <head>
    <title>your_domain website</title>
  </head>
  <body>
    <h1>Hello World!</h1>

    <p>This is the landing page of <strong>$Domain</strong>.</p>
  </body>
</html>" > /var/www/$Domain/index.html

# Install and Config PHP

sudo DEBIAN_FRONTEND="noninteractive" apt install -y --assume-yes php8.1-fpm php-mysql

sudo mv php.ini /etc/php/8.1/fpm/php.ini
sudo systemctl restart php8.1-fpm.service
sudo systemctl reload php8.1-fpm.service

printf "<?php
phpinfo();" > /var/www/$Domain/info.php


# Install and Configure mysql
sudo ufw allow mysql
sudo DEBIAN_FRONTEND="noninteractive" apt install -y --assume-yes mysql-server

mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '$DBPassword';"
mysql -e "DROP USER ''@'localhost'"
mysql -e "DROP USER ''@'$(hostname)'"
mysql -e "DROP DATABASE test"
mysql -e "FLUSH PRIVILEGES"

cp mysqld.cnf /etc/mysql/mysql.conf.d/mysqld.cnf

# Install and Configure letsencrypt ssl

sudo snap install core; 
sudo snap refresh core

sudo snap install --classic certbot

sudo ln -s /snap/bin/certbot /usr/bin/certbot

sudo ufw allow 'Nginx Full'
sudo ufw delete allow 'Nginx HTTP'

sudo certbot --nginx -d $Domain --non-interactive --agree-tos -m $EmailAddress
#sudo certbot --nginx -d www.$Domain --non-interactive --agree-tos -m $EmailAddress

#Innodb_buffer_pool_size 70-80% of server memory
#https://releem.com/docs/mysql-performance-tuning/innodb_buffer_pool_size
#https://scalegrid.io/blog/calculating-innodb-buffer-pool-size-for-your-mysql-server/

# Install network tools
apt DEBIAN_FRONTEND="noninteractive" install -y --assume-yes net-tools

# Enable the firewall
ufw allow 22/tcp
sudo ufw --force enable

#




