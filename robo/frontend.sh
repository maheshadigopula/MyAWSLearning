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

echo -n "Installing Ngnix: "
yum install nginx &>>$Logfile
stat $?

echo -n "Starting Nginx: "
systemctl start nginx
stat $?

echo -n "Downloading $COMPONENT: "
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
stat $?