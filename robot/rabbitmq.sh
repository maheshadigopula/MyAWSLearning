#!/bin/bash

COMPONENT=rabbitmq
source robot/common.sh

echo -e "\e[33m______ $COMPONENT Configuration Started _________ \e[0m"

echo -n "Installing and Configuring $COMPONENT :"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash &>> $LOGFILE
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash
yum install rabbitmq-server -y
stat $?

echo -n "Starting $COMPONENT :"
systemctl enable rabbitmq-server 
systemctl start rabbitmq-server
stat $?


