APPUSER=roboshop
LOFGILE="/tmp/$COMPONENT.log"



stat() {

    if [ $1 -eq 0 ]; then
        echo -e "\e[32m Success \0m]"
    else
        echo -e "\e[31m Failure \e0m"
    fi
}