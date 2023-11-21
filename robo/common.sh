set -e

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
        echo -e "\e[33m Failure\e[0m"
    fi
}