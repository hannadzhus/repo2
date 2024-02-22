#!/bin/bash
sudo su
# apt update -y &&
yum update # yum update for linux amazon
yum install nginx -y 
systemctl start nginx
systemctl enable nginx
echo "hello, Welcome to nginx !!!" > /var/www/html/index.html
systemctl restart nginx


# yum install httpd -y
# systemctl start httpd
# systemctl enable httpd
# echo "Hello, World! If you see this message then CF, EC2, SG was successful" > /var/www/html/index.html
# systemctl restart httpd