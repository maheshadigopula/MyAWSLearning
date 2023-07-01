#!/bin/bash

COMPONENT=catalogue
source robot/common.sh


echo -e "\e[33m______ $COMPONENT Configuration Started _________ \e[0m"


echo -n "Coonfiguring NodeJS Repo :"
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -  &>> $LOGFILE
yum install nodejs -y &>> $LOGFILE
stat $?

id ${APPUSER} &>> $LOGFILE
if [ $? -ne 0 ]; then
    echo -n "Creating Application User ${APPUSER} :"
    useradd ${APPUSER}  &>> $LOGFILE
    stat $?
fi

echo -n "Downloading the ${COMPONENT} :"
curl -s -L -o /tmp/${COMPONENT}.zip "https://github.com/stans-robot-project/${COMPONENT}/archive/main.zip" &>> ${LOGFILE}
stat $?

echo -n "Cleaning and Extarcting ${COMPONENT} :"
rm -rf ./home/${APPUSER}${COMPONENT}
cd /home/${APPUSER}
unzip -o /tmp/${COMPONENT}.zip &>> ${LOGFILE}
stat $?

echo -n "Changing the ownership to ${APPUSER} :" 
mv /home/$APPUSER/$COMPONENT-main /home/$APPUSER/$COMPONENT &>> ${LOGFILE}
chown -R $APPUSER:$APPUSER /home/${APPUSER}/${COMPONENT}
stat $?

echo -n "Installing ${COMPONENT} Dependencies :"
cd /home/${APPUSER}/${COMPONENT}
npm install &>> ${LOGFILE}
stat $?

echo -n "Configuring ${COMPONENT} Dependencies :"
mv /home/${APPUSER}/${COMPONENT}/systemd.service /etc/systemd/system/${COMPONENT}.service $>> ${LOGFILE}
sed -i -e 's/MONGO_DNSNAME/172.31.0.40/' /etc/systemd/system/catalogue.service $>> ${LOGFILE}
stat $?






echo -e "\e[33m______ $COMPONENT Configuration Completed _________ \e[0m"