#!/bin/bash

COMPONENT=frontend

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
yum install nginx -y &>> /tmp/${COMPONENT}.log
systemctl enable nginx &>> /tmp/${COMPONENT}.log
stat $?

echo -e -n "Starting nginx : "
systemctl start nginx &>> /tmp/${COMPONENT}.log
stat $?


# curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"


# cd /usr/share/nginx/html
# rm -rf *
# unzip /tmp/${COMPONENT}.zip
# mv ${COMPONENT}-main/* .
# mv static/* .
# rm -rf ${COMPONENT}-main README.md
# mv localhost.conf /etc/nginx/default.d/roboshop.conf
