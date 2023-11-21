#!/bin/bash

set -e

COMPONENT=frontend
Logfile="/tmp/$COMPONENT.log"

ID=$(id -u)
if [ $ID -ne 0 ] ; then
    echo -e "\e[33m You need to run as root user or use Sudo\e[0m"
    exit 1
fi


stat()
{
    if [ $1 -eq 0 ]; then
        echo -e "\e[32m Success\e[0m"
    else
        echo -e "\e[33m Failure\e[0m"
    fi
}



echo -e "\e[32m________$COMPONENT Configuration Started_________\e[0m"

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

