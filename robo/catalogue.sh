#!bin/bash/

source robo/common.sh
COMPONENT=catalogue
APPUSER=roboshop

echo -e "\e[33m_________Configuration started________\e[0m"

echo -n "Configuring NodeJS Repo:"
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - &>>$Logfile
yum install nodejs -y &>>$Logfile
stat $?

id $APPUSER &>>$Logfile
if [ $? -ne 0 ] ; then
    echo -n "Creating user $APPUSER:"
    useradd $APPUSER &>>$Logfile
    stat $?
fi

echo -n "Downloading the ${COMPONENT} :"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip" &>>$Logfile
stat $?

echo -n "Cleaning and Extarcting ${COMPONENT} :"
rm -rf /home/$APPUSER/$COMPONENT/
cd /home/$APPUSER
unzip -o /tmp/$COMPONENT.zip &>>$Logfile
stat $?

echo -n "Changing the ownership to ${APPUSER} :" 
mv /home/$APPUSER/$COMPONENT-main /home/$APPUSER/$COMPONENT &>>$Logfile
chown -R $APPUSER:$APPUSER /home/$APPUSER/$COMPONENT &>>$Logfile
stat $?

echo -n "Installing $COMPONENT Dependencies:"
cd /home/roboshop/catalogue &>>$Logfile
npm install &>>$Logfile
stat $?

echo -n "Configuring ${COMPONENT} Dependencies :"
mv /home/$APPUSER/$COMPONENT/systemd.service /etc/systemd/system/$COMPONENT.service &>>$Logfile
sed -i -e 's/MONGO_DNSNAME/172.31.0.209' /etc/systemd/system/${COMPONENT}.service &>>$Logfile
stat &?

echo -n "Restarting $COMPONENT services:"
systemctl daemon-reload &>>$Logfile
systemctl start catalogue &>>$Logfile
systemctl enable catalogue &>>$Logfile
systemctl status catalogue -l &>>$Logfile
stat $?





