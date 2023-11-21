#!/bin/bash

COMPONENT=frontent

echo -e "\e[32m________$COMPONENT Configuration Started_________\e[0m"


yum install nginx -y
systemctl enable nginx
systemctl start nginx
