#!/bin/bash

COMPONENT=mongodb
source common.sh

echo -e "\e[33m-------------------$COMPONENT Configuration started--------------------\e[0m"
echo -n "Downloading ${COMPONENT} :"
curl -s -o /etc/yum.repos.d/$COMPONENT.repo https://raw.githubusercontent.com/stans-robot-project/$COMPONENT/main/mongo.repo
stat $?


echo -e -n "Installing ${COMPONENT} :"
yum install -y $COMPONENT-org &>> $LOGFILE
systemctl enable mongod
systemctl start mongod &>> $LOGFILE
stat $?

echo -n "whitelisting the ${COMPONENT} :"
sed -i -e 's/127.0.0.1/0.0.0.0' /etc/mongod.conf &>> $LOGFILE
stat $?

echo -n "Restarting the ${COMPONENT} :"
systemctl restart mongod
stat $?

echo -n "Downloading the ${COMPONENT} schema :"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip" &>> $LOGFILE
stat $?


echo -n "Extracting the ${COMPONENT} schema file :"
cd /tmp
unzip $COMPONENT.zip &>> $LOGFILE
stat $?

echo -n "Injecting the schema :"
cd $COMPONENT-main
mongo < catalogue.js &>> $LOGFILE
mongo < users.js &>> $LOGFILE
stat $? 

echo -e "\e[33m---------------------------- $COMPONENT Configuration Completed -------------------------- \e[0m"
