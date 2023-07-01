#!/bin/bash

COMPONENT=frontend


source=common.sh


ID=(id -u)

if [ $ID -ne 0 ]; then
    echo "\e[31m You need to script either as a root user or with a sudo privilege \e[0m"
    exit 1
fi

echo -e "\e[33m----------Installing nginx----------\e[0m"

echo -e -n "Installing nginx : "
yum install nginx -y &>> /tmp/${COMPONENT}.log
systemctl enable nginx &>> /tmp/${COMPONENT}.log
stat $?

echo -e -n "Starting nginx : "
systemctl start nginx &>> /tmp/${COMPONENT}.log


# curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"


# cd /usr/share/nginx/html
# rm -rf *
# unzip /tmp/${COMPONENT}.zip
# mv ${COMPONENT}-main/* .
# mv static/* .
# rm -rf ${COMPONENT}-main README.md
# mv localhost.conf /etc/nginx/default.d/roboshop.conf
