#!/bin/bash

COMPONENT=rabbitmq
source robot/common.sh

echo -e "\e[33m______ $COMPONENT Configuration Started _________ \e[0m"

echo -n "Installing and Configuring $COMPONENT :"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash &>> $LOGFILE
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>> $LOGFILE
yum install rabbitmq-server -y &>> $LOGFILE
stat $?

echo -n "Starting $COMPONENT :"
systemctl enable rabbitmq-server &>> $LOGFILE
systemctl start rabbitmq-server
stat $?


rabbitmqctl list_users | grep ${APPUSER} &>> $LOGFILE
if [ $? -ne 0 ]; then 
    echo -n "Creating Application user on $COMPONENT :"
    rabbitmqctl add_user roboshop roboshop123 &>> "${LOGFILE}"
    stat $?
fi

echo -n "Adding permissions to ${APPUSER} :"
rabbitmqctl set_user_tags roboshop administrator
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"
stat $?
