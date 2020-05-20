# OSPOS on Ubuntu with Nginx
OSPOS, points of sales web app in Ubuntu

# Requirements
* Ubuntu Desktop 18.04 LTS
* Sudoer user

# Installation plan
* Hostname
* OpenSSH
* MySQL v5.7.30
* Nginx v1.14.0
* PHP v7.2.24
* PHP Modules relevant with PHP version
* OSPOS v3.3.1
* Login to OSPOS

# Do installation
## Hostname
Add `yourdomain.com` on line `localhost	127.0.0.1`
```sh
# localhost	127.0.0.1 yourdomain.com
sudo nano /etc/hosts
```

## OpenSSH
```sh
sudo apt update
sudo apt upgrade
sudo apt install openssh-server

# Auto start
sudo systemctl enable ssh

# Check status and start
sudo systemctl status ssh
sudo systemctl start ssh
```

Open ssh port: `22`
```sh
sudo ufw allow ssh
sudo ufw status
```

## MySQL
```sh
sudo apt update
sudo apt upgrade
sudo apt install mysql-server

# After this line, follow installation guide on your screen
sudo mysql_secure_installation
```

Entering MySQL shell for adjusting user authentication and privileges.
```sh
sudo mysql

mysql> SELECT user,authentication_string,plugin,host FROM mysql.user;
mysql> ALTER USER 'root'@'localhost' IDENTIFIED WITH mysql_native_password BY 'YOUR_ROOT_PASSWORD';
mysql> CREATE USER 'root'@'%' IDENTIFIED WITH mysql_native_password BY 'YOUR_ROOT_REMOTE_PASSWORD';
mysql> GRANT ALL PRIVILEGES ON *.* TO 'root'@'localhost' WITH GRANT OPTION;
mysql> GRANT ALL PRIVILEGES ON *.* TO 'root'@'%' WITH GRANT OPTION;
mysql> FLUSH PRIVILEGES;
mysql> EXIT;
```

Again, entering MySQL shell for create new user, this is mysql user for ospos app.
```sh
$ mysql -u root -p

mysql> CREATE DATABASE 'ospos';
mysql> CREATE USER 'ospos'@'localhost' IDENTIFIED WITH mysql_native_password BY 'YOUR_PASSWORD';
mysql> CREATE USER 'ospos'@'%' IDENTIFIED WITH mysql_native_password BY 'YOUR_REMOTE_PASSWORD';
mysql> GRANT ALL PRIVILEGES ON ospos.* TO 'ospos'@'localhost' WITH GRANT OPTION;
mysql> GRANT ALL PRIVILEGES ON ospos.* TO 'ospos'@'%' WITH GRANT OPTION;
mysql> FLUSH PRIVILEGES;
mysql> EXIT;
```

Open MySQL port `3306`. Update `bind-address` value with `0.0.0.0` on `/etc/mysql/mysql.conf.d/mysqld.cnf`
```sh
# bind-address = 0.0.0.0
sudo nano /etc/mysql/mysql.conf.d/mysqld.cnf
sudo ufw allow 3306/tcp
sudo ufw status

# Auto start mysql
sudo systemctl enable mysql.service

# Restart mysql
sudo systemctl restart mysql.service
sudo systemctl status mysql.service
```

Try login from external computer with command
```sh
mysql -u root -p -h REMOTE_IP_ADDRESS
```

## Nginx
```sh
sudo apt update
sudo apt upgrade
sudo apt install nginx=1.14.0

# Show status
sudo systemctl status nginx.service

# Auto start nginx
sudo systemctl enable nginx.service
```

Try Nginx
```sh
curl http://yourdomain.com
# You should see word something like "Welcome to nginx!"
```

Open Nginx port `80` (http) or `443` (ssl/https).
```sh
# Show available app to service
sudo ufw app list
# Available applications:
#   Nginx Full
#   Nginx HTTP
#   Nginx HTTPS
#   OpenSSH
sudo ufw allow 'Nginx Full'
sudo ufw status
```

## PHP
```sh
sudo apt update
sudo apt upgrade
sudo apt install php7.2-fpm
```

## PHP Modules
```sh
sudo apt update
sudo apt upgrade
sudo apt install php7.2-mysql php7.2-mbstring php7.2-xml php7.2-common php7.2-gd 
sudo apt install php7.2-json php7.2-cli php7.2-curl php7.2-intl php7.2-bcmath
```

Because `php-mcrypt` has deprecated since php v7, let do this stuff:
```sh
sudo apt update
sudo apt upgrade
sudo apt install php-dev libmcrypt-dev php-pear
sudo apt install apt-file
sudo apt-file update
sudo pecl channel-update pecl.php.net
sudo pecl install mcrypt-1.0.2
# You should see message, something like this:
# ...
# Build process completed successfully
# Installing '/usr/lib/php/20170718/mcrypt.so'
# install ok: channel://pecl.php.net/mcrypt-1.0.1
# configuration option "php_ini" is not set to php.ini location
# You should add "extension=mcrypt.so" to php.ini
```

Add `extension=mcrypt.so` to bottom line of `php.ini` files.
```sh
# extension=mcrypt.so
sudo nano /etc/php/7.2/cli/php.ini

# extension=mcrypt.so
sudo nano /etc/php/7.2/fpm/php.ini
```

Add service, and restart PHP
```sh
sudo systemctl enable php7.2-fpm.service
sudo systemctl restart php7.2-fpm.service
sudo systemctl status php7.2-fpm.service
```

Make sure PHP works along side Nginx
```sh
sudo unlink /etc/nginx/sites-enabled/default
sudo touch /etc/nginx/sites-available/yourdomain.com
sudo ln -s /etc/nginx/sites-available/yourdomain.com /etc/nginx/sites-enabled/
sudo nano /etc/nginx/sites-available/yourdomain.com
```

Add this lines
```text
server {
    server_name localhost;
    root /var/www/html/;
    index index.php index.html index.htm;
    server_name yourdomain.com;

    location = / {
        return 301 /public/;
    }

    location / {
        try_files $uri $uri/ /public/index.php;
    }

    location ~* ^.+.(jpg|jpeg|gif|css|png|js|ico|xml)$ {
        expires  15d;
    }

    location ~ \.php$ {
        include /etc/nginx/fastcgi_params;
        fastcgi_index  index.php;
        fastcgi_param  SCRIPT_FILENAME  /var/www/yourdomain.com/$fastcgi_script_name;
        fastcgi_param  REQUEST_URI      $request_uri;
        fastcgi_param  QUERY_STRING     $query_string;
        fastcgi_param  REQUEST_METHOD   $request_method;
        fastcgi_param  CONTENT_TYPE     $content_type;
        fastcgi_param  CONTENT_LENGTH   $content_length;
        fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
    }
}
```

Create OSPOS directory
```sh
sudo mkdir /var/www/yourdomain.com
sudo nano /var/www/yourdomain.com/phpinfo.php
```

Add this line
```text
<?php echo phpinfo(); ?>
```

Restart PHP and Nginx
```sh
sudo systemctl restart php7.2-fpm.service
sudo systemctl restart nginx.service
```

Try with visit `http://localhost/phpinfo.php` or `http://yourdomain.com/phpinfo.php`.
At the page check PHP modules.. it's should be enabled, also check `openssl` module and other related modules We has been installed before.


## OSPOS
```sh
wget https://github.com/opensourcepos/opensourcepos/releases/download/3.3.1/opensourcepos.20191214181241.3.3.1.c786d4.zip ospos-3.3.1.zip
unzip ospos-3.3.1.zip -d /var/www/yourdomain.com
sudo chown www-data /var/www/yourdomain.com -R
rm -f ospos-3.3.1.zip
```

Import database
```sh
mysql -u ospos -p -h localhost ospos < /var/www/yourdomain.com/database/database.sql
```

Modify `application/config/database.php` for database credentials. 
Change value of host = `localhost`, username = `ospos`, password = `YOUR_PASSWORD`, database name = `ospos`.
```sh
sudo nano /var/www/yourdomain.com/application/config/database.php
```

Modify `application/config/config.php` encryption key with your own
```sh
sudo nano /var/www/yourdomain.com/application/config/config.php
```

Restart PHP and Nginx
```sh
# Test Nginx configuration
sudo nginx -t

# Restart
sudo systemctl restart php7.2-fpm.service
sudo systemctl restart nginx.service
```

## Login to OSPOS
Browse `http://yourdomain.com`, this should be redirect to `http://yourdomain.com/public`.
For login, input this default account:
```text
username: admin
password: pointofsale
```
