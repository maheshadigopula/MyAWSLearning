#!/bin/bash

COMPONENT=mysql

APPUSER=roboshop
LOGFILE="/tmp/$COMPONENT.log"


stat() {
    if [ $1 -eq 0 ]; then 
        echo -e "\e[32m Success \e[0m "
    else 
        echo -e "\e[31m failure \e[0m"
    fi 
}

ID=$(id -u)
if [ $ID -ne 0 ]; then
    echo -e "\e[31mYou need to script either as a root user or with a sudo privilege \e[0m"
    exit 1
fi


echo -e "\e[33m______ $COMPONENT Configuration Started _________ \e[0m"

echo -n "Downloading the ${COMPONENT} Repo :"
curl -s -L -o /etc/yum.repos.d/${COMPONENT}.repo https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/mysql.repo &>> $LOGFILE
stat $?

echo -n "Installing ${COMPONENT} :"
yum install mysql-community-server -y &>> $LOGFILE
stat $?

echo -n "Starting ${COMPONENT} :"
systemctl enable mysqld &>> $LOGFILE
systemctl start mysqld &>> $LOGFILE
stat $?

echo -n "Fetching the default password :"
DEFAULT_ROOT_PWD=$(grep 'A temporary password' /var/log/mysqld.log | awk '{print $NF}') 
stat $?

echo "show databases;" | mysql -uroot -pRoboShop@1 &>> $LOGFILE
if [ $? -ne 0 ]; then
    echo -n "Resetting the default root password :"
    echo "ALTER USER 'root'@'localhost' IDENTIFIED By 'RoboShop@1';" | mysql --connect-expired-password -uroot -p${DEFAULT_ROOT_PWD} &>> $LOGFILE
    stat $?
fi

echo show plugins | mysql -uroot -pRoboShop@1 | grep validate_password  &>> "${LOGFILE}"
if [ $? -eq 0 ]; then 
    echo -n "Uninstalling Password Validate Plugin :"
    echo "uninstall plugin validate_password;"|  mysql -uroot -pRoboShop@1 &>> "${LOGFILE}"
    stat $?
fi 

echo -n "Downloading ${COMPONENT} schema :"
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip" &>> $LOGFILE
cd /tmp
unzip -o $COMPONENT.zip &>> $LOGFILE
stat $?

echo -n "Injecting $COMPONENT schema :"
cd $COMPONENT-main
mysql -u root -pRoboShop@1 < shipping.sql &>> $LOGFILE
stat $?

echo -e "\e[33m______ $COMPONENT Configuration Completed _________ \e[0m"

