#!/bin/bash

COMPONENT=mongodb
source common.sh

echo -n "Downloading ${COMPONENT} :"
curl -s -o /etc/yum.repos.d/${COMPONENT}.repo https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/mongo.repo &>> ${LOGFILE}
stat $?

echo -e -n "\eInstalling ${COMPONENT} :"
yum install -y mongodb-org
stat $?

Echo -e -n "Starting ${COMPONENT} :"
systemctl enable mongod
systemctl start mongod
stat $?


