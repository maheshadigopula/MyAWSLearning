#!/bin/bash

COMPONENT=mongodb

source /robot/common.sh

echo -n "Downloading ${COMPONENT}"
curl -s -o /etc/yum.repos.d/mongodb.repo https://raw.githubusercontent.com/stans-robot-project/mongodb/main/mongo.repo &>> $LOGFILE
stat $?

