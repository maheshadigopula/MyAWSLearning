#!/bin/bash

COMPONENT=frontend
LOGFILE=/tmp/${COMPONENT}.log

stat() {
    if [ $1 -eq 0 ]; then 
        echo -e "\e[32m Success \e[0m "
    else 
        echo -e "\e[31m failure \e[0m"
    fi 
}

ID=$(id -u)
if [ $ID -ne 0 ]; then
    echo -e "\e[31mYou need to script either as a root user or with a sudo privilege \e[0m"
    exit 1
fi

echo -e "\e[33m----------Installing nginx----------\e[0m"
echo -e -n "Installing nginx : "
yum install nginx -y &>> $LOGFILE
systemctl enable nginx &>> $LOGFILE
stat $?

echo -e -n "Starting nginx : "
systemctl start nginx &>> $LOGFILE
stat $?

echo -e -n "Downloading the ${COMPONENT} : "
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
stat $?

echo -e -n "Clearing the default content : "
cd /usr/share/nginx/html
rm -rf *
stat $?

echo -e -n "Extracting the ${COMPONENT} : "
unzip /tmp/${COMPONENT}.zip &>> $LOGFILE

echo -e -n "Copying the ${COMPONENT} : "
mv ${COMPONENT}-main/* . &>> $LOGFILE
mv static/* . &>> $LOGFILE
rm -rf ${COMPONENT}-main README.md &>> $LOGFILE
mv localhost.conf /etc/nginx/default.d/roboshop.conf &>> $LOGFILE
stat $?

