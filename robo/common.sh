
APPUSER=roboshop
Logfile="/tmp/$COMPONENT.log"

ID=$(id -u)
if [ $ID -ne 0 ] ; then
    echo -e "\e[33m You need to run as root user or use Sudo\e[0m"
    exit 1
fi

stat()
{
    if [ $1 -eq 0 ]; then
        echo -e "\e[32m Success\e[0m"
    else
        echo -e "\e[31m Failure\e[0m"
    fi
}

NODEJS(){

   echo -n "Configuring Node JS:"
    curl -sL https://rpm.nodesource.com/setup_16.x | bash  &>>$Logfile
    stat $? 

    echo -n "Installing nodeJs : "
    yum install nodejs -y &>>$Logfile
    stat $?  
}

Creating_User(){
    id $APPUSER &>>$Logfile
    if [ $? -ne 0 ] ; then
        echo -n "Creating user $APPUSER:"
        useradd $APPUSER &>>$Logfile
        stat $?
    fi
}


Downloading_And_Extracting()
{
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
}

NPM_Install()
{  
    echo -n "Installing $COMPONENT Dependencies:"
    cd /home/$APPUSER/$COMPONENT &>>$Logfile
    npm install &>>$Logfile
    stat $?
}


Configuring_SVC()
{
    echo -n "Configuring ${COMPONENT} Dependencies :"
    mv /home/$APPUSER/$COMPONENT/systemd.service /etc/systemd/system/$COMPONENT.service &>>$Logfile
    sed -i -e 's/MONGO_DNSNAME/172.31.0.209/' /etc/systemd/system/$COMPONENT.service &>>$Logfile
    stat $?

    echo -n "Restarting $COMPONENT services:"
    systemctl daemon-reload &>>$Logfile
    systemctl start $COMPONENT &>>$Logfile
    systemctl enable $COMPONENT &>>$Logfile
    systemctl status $COMPONENT &>>$Logfile
    stat $?
}

JAVA()
{
    echo -n "Installing Maven:"
    yum install maven -y  &>>$Logfile
    stat $?
}


PYTHON() {
   echo -n "Installing python3 and other dependencies : "
   yum install python36 gcc python3-devel -y  &>>Logfile
   stat $? 

    CREATE_USER             # Calling Create_User function to create user account

    DOWNLOAD_AND_EXTRACT 

    cd /home/$APPUSER/$COMPONENT/ 
    pip3 install -r requirements.txt &>>Logfile
    stat $?  

    USERID=$(id -u roboshop)
    GROUPID=$(id -g roboshop)

    echo -n "Updating the UID and GID in the $COMPONENT.ini file : "
    sed -i -e "/^uid/ c uid=${USERID}"  -e "/^gid/ c gid=${GROUPID}" /home/$APPUSER/$COMPONENT/$COMPONENT.ini 
    stat $?  

    CONFIGURE_SVC           # Configuring and starting service

}