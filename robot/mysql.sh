#!/bin/bash

COMPONENT=mysql
source robot/common.sh

echo -n "Downloading the ${COMPONENT} Repo :"
curl -s -L -o /etc/yum.repos.d/${COMPONENT}.repo https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/mysql.repo
stat $?

echo -n "Installing ${COMPONENT} :"
yum install mysql-community-server -y
stat $?

echo -n "Starting ${COMPONENT} :"
systemctl enable mysqld 
systemctl start mysqld
stat $?

