#!/bin/bash/

source robo/common.sh
COMPONENT=rabbitmq

echo -e "\e[31m_____________Configuration Started______________\e[0m"

echo -n "Downloading $COMPONENT dependencies:"
curl -s https://packagecloud.io/install/repositories/$COMPONENT/erlang/script.rpm.sh | sudo bash &>>$Logfile
curl -s https://packagecloud.io/install/repositories/$COMPONENT/$COMPONENT-server/script.rpm.sh | sudo bash &>>$Logfile
stat $?

echo -n "Installing $COMPONENT:"
yum install rabbitmq-server -y &>>$Logfile
stat $?

echo -n "Starting $COMPONENT:"
systemctl enable rabbitmq-server 
systemctl start rabbitmq-server
stat $?

sudo rabbitmqctl list_users | grep "${roboshop}" &>>$Logfile
if[ $? -ne 0 ]; then
    echo -n "Creating Applicaiton user on $COMPONENT: "
    rabbitmqctl add_user roboshop roboshop123 &>>$Logfile
    stat $?
fi

echo -n "Adding permissions to $APPUSER:"
rabbitmqctl set_user_tags roboshop administrator &>>$Logfile
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*" &>>$Logfile
stat $?

echo -e "\e[31m __________ $COMPONENT Installation Completed _________ \e[0m"

