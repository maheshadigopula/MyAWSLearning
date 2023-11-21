#!/bin/bash

source robo/common.sh

COMPONENT=mongodb


echo -e "\e[33m________Configuration Started________\e[0m"

echo -n "Downloading $COMPONENT:"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
stat $?


echo -n "Installing $COMPONENT:"
yum install -y mongodb-org &>>$Logfile
stat $?

echo -n "Starting $COMPONENT:"
systemctl enable mongod &>>$Logfile
systemctl start mongod &>>$Logfile
stat $?

echo -n -e "whitelisting the ${COMPONENT} :"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat $?

echo -n "Restarting $COMPONENT:"
systemctl restart mongod &>>$Logfile
stat $?

echo -n "Downloading the schema:"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
stat $?

echo -n "Extracting the $COMPONENT schema:"
cd /tmp
unzip -o $COMPONENT.zip &>>$Logfile
stat $?


echo -n "Injecting the $COMPONENT schema:"
cd $COMPONENT-main 
mongo < catalogue.js &>>$Logfile
mongo < users.js &>>$Logfile
stat $?


echo -e "\e[33m______ $COMPONENT Configuration Completed _________ \e[0m"