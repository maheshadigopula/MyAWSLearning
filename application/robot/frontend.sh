#!/bin/bash

COMPONENT=frontend
source common.sh

echo -e "\e[33m-------------------$COMPONENT Configuration started--------------------\e[0m"

echo -n "Installing Nginx: "
yum install nginx -y  &>> $LOGFILE
systemctl enable nginx &>> $LOGFILE
systemctl start nginx &>> $LOGFILE
stat $?

echo -n "Downloading the $COMPONENT: "
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip" &>> $LOGFILE
stat $?

echo -n "Clearing the Default content: "
cd /usr/share/nginx/html 
rm -rf * &>> $LOGFILE
stat $?

echo -n "Extracting the $COMPONENT: "
unzip /tmp/$COMPONENT.zip &>> $LOGFILE
mv $COMPONENT-main/* . &>> $LOGFILE
mv static/* . &>> $LOGFILE
rm -rf $COMPONENT-main README.md
mv localhost.conf /etc/nginx/default.d/$APPUSER.conf
stat $?
