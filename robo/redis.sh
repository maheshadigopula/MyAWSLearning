#!/bin/bash/

source robo/common.sh
COMPONENT=redis

echo -e "\e[33m_________Configuration started_________\e[0m"


echo -n "Configuring the $COMPONENT Repo:"
curl -L https://raw.githubusercontent.com/stans-robot-project/$COMPONENT/main/$COMPONENT.repo -o /etc/yum.repos.d/$COMPONENT.repo &>>$Logfile
stat $?

echo -n "Installing $COMPONENT:"
yum install redis-6.2.13 -y &>>$Logfile
stat $?

echo -n "whitelisting the $COMPONENT"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/$COMPONENT.conf
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/$COMPONENT/$COMPONENT.conf
stat $?

echo -n "Starting $COMPONENT : "
systemctl daemon-reload 
systemctl enable $COMPONENT &>>$Logfile
systemctl restart  $COMPONENT &>>$Logfile
stat $? 

echo -e "\e[33m______ $COMPONENT Configuration Completed _________ \e[0m"