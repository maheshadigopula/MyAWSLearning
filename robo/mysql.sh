#!/bin/bash/

source robo/common.sh
COMPONENT=mysql

echo -e "\e[31m_____________Configuration Started___________\e[0m"

echo -n "Configuring the $COMPONENT Repo:"
curl -s -L -o /etc/yum.repos.d/$COMPONENT.repo https://raw.githubusercontent.com/stans-robot-project/$COMPONENT/main/$COMPONENT.repo
stat $?

echo -n "Installing the $COMPONENT:"
yum install mysql-community-server -y
stat $?

echo -n "Starting the $COMPONENT:"
systemctl enable mysqld 
systemctl start mysqld
stat $?

echo -n "Fetching the default root password:"
DEFAULT_ROOT_PWD=$(grep 'A temporary password' /var/log/mysqld.log | awk '(print NF)')
stat $?


echo show databases; | mysql -uroot -pRoboShop@1 &>>$Logfile
if[ $? -ne 0 ]; then 
    echo -n "Resetting the default password:"
    echo "Alter USER 'root'@'localhost' IDENTIFIED BY 'pRoboShop@1';" | mysql --connect-expired-password -uroot -p${DEFAULT_ROOT_PWD} &>>$Logfile
    stat $?
fi

echo "show plugins;" | mysql -uroot -pRoboShop@1 | grep validate_password; &>>$Logfile 
if[$? -eq 0 ]; then 
    echo -n "Uninstalling the validate_password plugin:"
    echo "uninstall plugin validate_password;" | mysql -uroot -pRoboShop@1 &>>$Logfile
    stat $?
fi

echo -n "Downloading the $COMPONENT Schema:"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip"
cd /tmp
unzip -o $COMPONENT.zip
stat $?

echo -n "Injecting the $COMPONENT schema:" 
cd $COMPONENT-main
mysql -u root -pRoboShop@1 <shipping.sql
stat $?

echo -e "\e[31m_____________Configuration Completed_______________\e[0m"







