#!/bin/bash

source robo/common.sh

COMPONENT=mongodb


echo -e "\e[32m________Configuration Started________\e[0m"

echo -n -e "\e[32mDownloading $COMPONENT:\e[0m"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
stat $?


echo -n -e "\e[32mInstalling $COMPONENT:\e[0m"
yum install -y mongodb-org &>>$Logfile
stat $?

echo -n -e "e[32mStarting $COMPONENT:\e[0m"
systemctl enable mongod &>>$Logfile
systemctl start mongod &>>$Logfile
stat $?

echo -n -e "whitelisting the ${COMPONENT} :"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat $?



