#!/bin/bash
exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1
# package updates
sudo yum update -y
# apache installation, enabling and status check
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd
sudo systemctl status httpd | grep Active
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
systemctl reload httpd