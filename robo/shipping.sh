#!/bin/bash/

source robo/common.sh
COMPONENT=shipping

JAVA
Creating_User
Downloading_And_Extracting

echo -n "Generating the artifact:"
cd /home/$APPUSER/$COMPONENT/
mvn clean package &>>$Logfile
mv target/$COMPONENT-1.0.jar $COMPONENT.jar

Configuring_SVC
