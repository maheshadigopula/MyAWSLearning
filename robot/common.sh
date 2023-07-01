APPUSER=roboshop
LOFGILE="/tmp/$COMPONENT.log"

ID=$(id -u)

if [ ID -ne 0]; then
    echo "\e[31m You need to script either as a root user or with a sudo privilege \e[0m"
fi

