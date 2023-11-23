#!/bin/bash/

source robo/common.sh
COMPONENT=payment

echo -e "\e[31m_____________Configuration started__________\e[0m"

echo -n "Installing python3 and other dependencies:"
yum install python36 gcc python3-devel -y &>>$COMPONENT
stat $?

Creating_User
Downloading_And_Extracting

cd /home/$APPUSER/$COMPONENT 
pip3 install -r requirements.txt

USERID=$(id -u roboshop)
GRPID=$(is -g roboshop)

echo -n "Updating the UID and GID in $COMPONENT.ini file:"
sed -i -e "/^uid/ c uid=${USERID}" -e "/^gid/ c gid=${GRPID}" /home/$APPUSER/$COMPONENT/$COMPONENT.ini
stat $?

Configuring_SVC


echo -e "\e[31m_____________Configuration Completed_______________\e[0m"
