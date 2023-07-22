APPUSER=roboshop
LOGFILE="/tmp/$COMPONENT.log"

stat() {

    if [ $1 -eq 0 ]; then
        echo -e "\e[32mSuccess\e[0m"
    else
        echo -e "\e[31mFailure\e[0m"
    fi
}

NODEJS() {
    echo -n "Configuring NodeJS Repo :"
    curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash - &>> $LOGFILE
    yum install nodejs -y &>> $LOGFILE
    stat $?
}