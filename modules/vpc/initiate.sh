#! /bin/bash
sudo apt-get update
sudo apt-get -y install nginx
sudo apt-get install php5-pgsql
sudo apt-get install libapache2-mod-php5
sudo /etc/init.d/apache2 restart
echo "
server {

    listen 80 default_server;
    listen [::]:80 default_server;

    server_name _;

    root /var/www/html;

    index index.html;

    try_files $uri /index.html;
}
" > /etc/nginx/sites-available/default
sudo systemctl restart nginx

echo 'Hola Hello World... EC2 working!!!' > /var/www/html/index.html