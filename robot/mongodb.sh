#!/bin/bash

COMPONENT=mongodb
source common.sh

echo -n "Downloading ${COMPONENT} :"
curl -s -o /etc/yum.repos.d/${COMPONENT}.repo https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/mongo.repo &>> ${LOGFILE}
stat $?

echo -e -n "Installing ${COMPONENT} :"
yum install -y mongodb-org &>> $LOGFILE
stat $?

echo -e -n "Starting ${COMPONENT} :"
systemctl enable mongod
systemctl start mongod
stat $?

echo -n "whitelisting the ${COMPONENT}"
sed -i -e  's/127.0.0.1/0.0.0.0/' /etc/mongod.conf
stat $?

