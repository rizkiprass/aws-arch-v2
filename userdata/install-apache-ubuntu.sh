#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
# package updates
sudo apt update -y
# apache installation, enabling and status check
sudo apt -y install apache2
sudo systemctl enable apache2.service
sudo systemctl start apache2.service
sudo systemctl status apache2.service
## apache configuration multiple domain
#domain=test.com
#root="/var/www/html/$domain"
#block="/etc/httpd/conf.d/test.conf"
#
#sudo mkdir -p $root
#
#cat << EOF > $block
#<VirtualHost *:80>
#    ServerName 54.187.217.233
#    DocumentRoot $root
#
#    ErrorLog /var/log/httpd/example.com-error_log
#    CustomLog /var/log/httpd/example.com-access_log combined
#</VirtualHost>
#EOF
# apache configuration
domain=test.com
root="/var/www/html/"
block="/etc/httpd/conf.d/test.conf"

sudo mkdir -p $root

cat << EOF > $block
<VirtualHost *:80>
    ServerName $domain
    DocumentRoot $root

    ErrorLog /var/log/httpd/example.com-error_log
    CustomLog /var/log/httpd/example.com-access_log combined
</VirtualHost>
EOF

# Create the index.html:
echo "<h1>welcome</h1>" | sudo tee $root/index.html

# Reload apache
#sudo systemctl restart apache2.service
sudo service apache2 reload