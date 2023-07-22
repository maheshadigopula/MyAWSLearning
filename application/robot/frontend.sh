#!/bin/bash

COMPONENT = frontend
source common.sh

echo -e "\e[33m-------------------$COMPONENT Configuration started--------------------"

echo -n -e "Installing Nginx: "
yum install nginx -y
systemctl enable nginx
systemctl start nginx




