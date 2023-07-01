APPUSER=roboshop
LOFGILE="/tmp/$COMPONENT.log"

ID=$(id -u)
if [ $ID -ne 0 ]; then
    echo -e "\e[31mYou need to script either as a root user or with a sudo privilege \e[0m"
    exit 1
fi


stat() {

    if [ $1 -eq 0 ]; then
        echo -e "\e[32m Success \0m]"
    else
        echo -e "\e[31m Failure \e0m"
    fi
}