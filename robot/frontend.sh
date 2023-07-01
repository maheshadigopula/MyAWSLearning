#!/bin/bash

COMPONENT=frontend
LOGFILE=/tmp/${COMPONENT}.log

source common.sh

echo -e "\e[33m______ $COMPONENT Configuration Started _________ \e[0m"
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
stat $?

echo -e -n "Copying the ${COMPONENT} : "
mv ${COMPONENT}-main/* . &>> $LOGFILE
mv static/* . &>> $LOGFILE
rm -rf ${COMPONENT}-main README.md &>> $LOGFILE
mv localhost.conf /etc/nginx/default.d/roboshop.conf &>> $LOGFILE
stat $?

echo -n "Restarting Nignx :"
systemctl enable nginx    &>> "${LOGFILE}"
systemctl restart nginx   &>> "${LOGFILE}"
stat $?

echo -e "\e[33m______ $COMPONENT Configuration Completed _________ \e[0m"
