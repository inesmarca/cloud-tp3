#! /bin/bash
sudo apt-get update
sudo apt-get -y install nginx
sudo apt-get install php5-pgsql
sudo apt-get install libapache2-mod-php5
sudo /etc/init.d/apache2 restart
echo "##
# You should look at the following URL's in order to grasp a solid understanding
# of Nginx configuration files in order to fully unleash the power of Nginx.
# https://www.nginx.com/resources/wiki/start/
# https://www.nginx.com/resources/wiki/start/topics/tutorials/config_pitfalls/
# https://wiki.debian.org/Nginx/DirectoryStructure
#
# In most cases, administrators will remove this file from sites-enabled/ and
# leave it as reference inside of sites-available where it will continue to be
# updated by the nginx packaging team.
#
# This file will automatically load configuration files provided by other
# applications, such as Drupal or Wordpress. These applications will be made
# available underneath a path with that package name, such as /drupal8.
#
# Please see /usr/share/doc/nginx-doc/examples/ for more detailed examples.
##

# Default server configuration
#

server {
	listen 80 default_server;
	listen [::]:80 default_server;

	root /var/www/html;

	# Add index.php to the list if you are using PHP
	index index.html index.htm index.nginx-debian.html;

	server_name _;

	location / {
		# First attempt to serve request as file, then
		# as directory, then fall back to displaying a 404.
		try_files '' /var/www/html/index.html;
        add_header Access-Control-Allow-Origin *;
	}

    error_page 404 /error.html;
    location = /error.html {
        root /var/www/html;
        internal;
        add_header Access-Control-Allow-Origin *;
    }
}
" > /etc/nginx/sites-available/default
sudo systemctl restart nginx

echo 'Hola Hello World... EC2 working!!!' > /var/www/html/index.html
echo 'Error Hello World... EC2 working!!!' > /var/www/html/error.html