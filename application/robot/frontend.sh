#!/bin/bash

COMPONENT=frontend
source common.sh

echo -e "\e[33m-------------------$COMPONENT Configuration started--------------------"

echo -n "Installing Nginx: "
yum install nginx -y  &>> $LOGFILE
systemctl enable nginx &>> $LOGFILE
systemctl start nginx &>> $LOGFILE
stat $?

echo -n "Extracting the $COMPONENT: "
curl -s -L -o /tmp/frontend.zip "https://github.com/stans-robot-project/frontend/archive/main.zip" &>> $LOGFILE
stat $?

# cd /usr/share/nginx/html
# rm -rf *
# unzip /tmp/frontend.zip
# mv frontend-main/* .
# mv static/* .
# rm -rf frontend-main README.md
# mv localhost.conf /etc/nginx/default.d/roboshop.conf