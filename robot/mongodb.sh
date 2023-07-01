#!/bin/bash

COMPONENT=mongodb

source robot/common.sh

echo -e "\e[33m______ $COMPONENT Configuration Started _________ \e[0m"

echo -n "Downloading ${COMPONENT} :"
curl -s -o /etc/yum.repos.d/${COMPONENT}.repo https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/mongo.repo &>> ${LOGFILE}
stat $?

echo -e -n "Installing ${COMPONENT} :"
yum install -y ${COMPONENT}-org &>> $LOGFILE
stat $?

echo -e -n "Starting ${COMPONENT} :"
systemctl enable mongod
systemctl start mongod
stat $?

echo -n "whitelisting the ${COMPONENT} :"
sed -i -e  's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat $?

echo -n "Restarting the ${COMPONENT} :"
systemctl restart mongod
stat $?

echo -n "Downloading the ${COMPONENT} schema :"
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip"
stat $?

echo -n "Extracting the ${COMPONENT} schema file :"
cd /tmp
unzip -o ${COMPONENT}.zip &>> ${LOGFILE}
stat $?

echo -n "Injecting the schema :"
cd ${COMPONENT}-main &>> ${LOGFILE}
mongo < catalogue.js &>> ${LOGFILE}
mongo < users.js &>> ${LOGFILE}
stat $?




echo -e "\e[33m______ $COMPONENT Configuration Completed _________ \e[0m"
