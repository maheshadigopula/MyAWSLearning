#!/bin/bash 

COMPONENT=rabbitmq
source robo/common.sh

echo -n "Installing and configuring $COMPONENT repo"
curl -s https://packagecloud.io/install/repositories/rabbitmq/erlang/script.rpm.sh | sudo bash  &>>Logfile
curl -s https://packagecloud.io/install/repositories/rabbitmq/rabbitmq-server/script.rpm.sh | sudo bash &>>Logfile
stat $? 

echo -n "Installing $COMPONENT : "
yum install rabbitmq-server -y &>>Logfile
stat $?

echo -n "Starting $COMPONENT :"
systemctl enable rabbitmq-server &>>Logfile
systemctl start rabbitmq-server  &>>Logfile
stat $? 

sudo rabbitmqctl list_users | grep "${APPUSER}" &>>Logfile 
if [ $? -ne 0 ]; then 
    echo -n "Creating Applicaiton user on $COMPONENT: "
    rabbitmqctl add_user roboshop roboshop123 &>>Logfile
    stat $? 
fi 


echo -n "Adding Permissions to $APPUSER :"
rabbitmqctl set_user_tags roboshop administrator &>>Logfile
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>Logfile
stat $?


echo -e "\e[32m __________ $COMPONENT Installation Completed _________ \e[0m"