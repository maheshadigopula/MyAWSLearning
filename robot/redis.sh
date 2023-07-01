#!/bin/bash

COMPONENT=redis
source robot/common.sh

echo -e "\e[33m______ $COMPONENT Configuration Started _________ \e[0m"

echo -n "Configuring the ${COMPONENT} Repo :"
curl -L https://raw.githubusercontent.com/stans-robot-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo &>> ${LOGFILE}
stat $?

echo -n "Installing the ${COMPONENT} :"
yum install redis-6.2.11 -y &>> ${LOGFILE}
stat $?

echo -n "Whitelising the ${COMPONENT} :"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf &>> ${LOGFILE}
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf &>> ${LOGFILE}
stat $?

echo -n "Starting ${COMPONENT} Service :"
systemctl enable redis &>> ${LOGFILE}
systemctl start redis &>> ${LOGFILE}
stat $?