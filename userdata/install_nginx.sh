#!/bin/bash
sudo apt update
sudo apt install nginx -y

domain=rp-server.site
root="/var/www/$domain"
block="/etc/nginx/sites-available/$domain"

# Create the Document Root directory
sudo mkdir -p $root

# Create the index.html:
echo "<h1>welcome</h1>" | sudo tee $root/index.html

# Remove default Nginx configuration
sudo rm /etc/nginx/sites-enabled/default

# Create the Nginx server block file:
sudo tee $block > /dev/null <<EOF
server {
        listen 80;
        listen [::]:80;

        root $root;
        index index.html;

        server_name $domain;

        location / {
                try_files \$uri \$uri/ =404;
        }
}
EOF

# Link to make it available
sudo ln -s $block /etc/nginx/sites-enabled/

# Test configuration and reload if successful
sudo nginx -t && sudo systemctl reload nginx