#!/bin/bash

COMPONENT=mongodb
LOGFILE=/tmp/${COMPONENT}.log

source common.sh

echo -n "Downloading ${COMPONENT}"
curl -s -o /etc/yum.repos.d/${COMPONENT}.repo https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/mongo.repo &>> ${LOGFILE}


