#!/bin/bash
set -e
source robo/common.sh

COMPONENT=frontend

echo -e "\e[33m________$COMPONENT Configuration Started_________\e[0m"

echo -n "Installing Ngnix:"
yum install nginx &>>$Logfile
stat $?

echo -n "Starting Nginx:"
systemctl start nginx
stat $?

echo -n "Downloading $COMPONENT:"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
stat $?

echo -e -n "Clearing the default content: "
cd /usr/share/nginx/html &>>$Logfile
rm -rf *
stat $?

echo -e -n "Extracting the $COMPONENT:"
unzip /tmp/$COMPONENT.zip &>>$Logfile
stat $?

echo -e -n "Copying the ${COMPONENT}: "
mv frontend-main/* .
mv static/* .
rm -rf frontend-main README.md &>>$Logfile
mv localhost.conf /etc/nginx/default.d/roboshop.conf &>>$Logfile
stat $?

echo -n "Restarting Nignx :"
systemctl enable nginx    &>>$Logfile
systemctl restart nginx   &>>$Logfile
stat $?

echo -e "\e[33m______ $COMPONENT Configuration Completed _________ \e[0m"

