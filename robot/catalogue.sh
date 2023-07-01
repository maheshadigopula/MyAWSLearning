#!/bin/bash

COMPONENT=catalogue
source robot/common.sh


echo -e "\e[33m______ $COMPONENT Configuration Started _________ \e[0m"


echo -n "Coonfiguring NodeJS Repo :"
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -  &>> $LOGFILE
yum install nodejs -y &>> $LOGFILE
stat $?












echo -e "\e[33m______ $COMPONENT Configuration Completed _________ \e[0m"