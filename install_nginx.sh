#!/bin/bash

sudo apt-get update
sudo apt-get -y install nginx

domain=rp-server.site
root="/var/www/html/$domain"
block="/etc/nginx/sites-available/$domain"

# Create the Document Root directory
sudo mkdir -p $root

rm /etc/nginx/sites-available/default

# Create the Nginx server block file:
sudo tee $block > /dev/null <<EOF
server {
        listen 80 default_server;
        listen [::]:80 default_server;

        root /var/www/html/$domain;
        index index.html index.htm;

        server_name _;

        location / {
                try_files $uri $uri/ =404;
        }
}


EOF

# Create the index.html:
echo "<h1>welcome</h1>" | sudo tee /var/www/html/rp-server.site/index.html

rm /etc/nginx/sites-enabled/default

# Link to make it available
sudo ln -s $block /etc/nginx/sites-enabled/

# Test configuration and reload if successful
sudo nginx -t && sudo service nginx reload