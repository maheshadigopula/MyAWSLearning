#!bin/bash/

source robo/common.sh
COMPONENT=catalogue
APPUSER=roboshop

echo -e "\e[31m_________Configuration started________\e[0m"

echo -n "Configuring NodeJS Repo:"
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - &>>$Logfile
yum install nodejs -y &>>$Logfile
stat $?

id $APPUSER
if [ $? -ne 0 ] ; then
    echo -e "Creating user $APPUSER:"
    useradd $APPUSER &>>$Logfile
    stat $?
fi





