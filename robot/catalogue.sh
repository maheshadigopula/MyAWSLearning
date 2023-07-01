#!/bin/bash

COMPONENT=catalogue
sourche robot/common.sh

echo -n "Coonfiguring NodeJS Repo :"
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -
yum install nodejs -y &>> $LOGFILE
stat $?

