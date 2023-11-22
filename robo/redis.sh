#!/bin/bash/

source robo/common.sh
COMPONENT=redis

echo -e "\e[31m_________Configuration started_________\e[0m"


echo -n "Configuring the $COMPONENT Repo:"
curl -L https://raw.githubusercontent.com/stans-robot-project/redis/main/redis.repo -o /etc/yum.repos.d/redis.repo &>>$Logfile
stat $?

echo -n "Installing $COMPONENT:"
yum install redis-6.2.13 -y &>>&Logfile
stat $?

echo -n "whitelisting the $COMPONENT"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis.conf
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis/redis.conf
stat $?

echo -n "Starting $COMPONENT : "
systemctl daemon-reload 
systemctl enable $COMPONENT &>> "${LOFGILE}"
systemctl restart  $COMPONENT &>> "${LOFGILE}"
stat $? 

