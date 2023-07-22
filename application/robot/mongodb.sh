#!/bin/bash

COMPONENT=mongodb
source common.sh

echo -e "\e[33m-------------------$COMPONENT Configuration started--------------------\e[0m"
echo -n "Downloading ${COMPONENT} :"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo
stat $?


echo -e -n "Installing ${COMPONENT} :"
yum install -y mongodb-org
systemctl enable mongod
systemctl start mongod
stat $?


# systemctl restart mongod

# curl -s -L -o /tmp/mongodb.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip"

# cd /tmp
# unzip mongodb.zip
# cd mongodb-main
# mongo < catalogue.js
# mongo < users.js

