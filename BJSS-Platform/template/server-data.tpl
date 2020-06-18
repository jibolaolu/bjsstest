#!/bin/bash

set -e

#Installing httpd on the instance
sudo yum update -y
sudo yum install httpd -y
sudo systemctl start httpd
sudo systemctl enable httpd 
echo "<h1>HELLO WORLD from BJSS</h1>" >> /var/www/html/index.html