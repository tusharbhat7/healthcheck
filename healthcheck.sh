#!/bin/bash

# Server health check script
# Author:Tushar

echo "Starting health check..."

echo ""
echo "Installing Apache and redis"
sudo apt update -y
sudo apt install -y apache2 redis-server

echo ""
echo "Starting services (redis and apache2)"
sudo systemctl start apache2
sudo systemctl start redis-server

echo ""
echo "Enabling services on boot"
sudo systemctl enable apache2
sudo systemctl enable redis-server

echo ""
echo "Checking disk space"
df -h

echo ""
echo "Checking memory"
free -h

echo ""
echo "Checking cpu count"
nproc

echo ""
echo "Checking services status"

apache_status=$(systemctl is-active apache2)
redis_status=$(systemctl is-active redis-server)

echo "Apache status: $apache_status"
echo "Redis status: $redis_status"

if [ "$apache_status" = "active" ] && [ "$redis_status" = "active" ];
then
    echo "Services are running fine"
else
    echo "Something went wrong, check services "
fi

