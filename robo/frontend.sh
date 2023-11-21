#!/bin/bash

set -e

COMPONENT=frontend
Logfile= "/tmp/#COMPONENT.log"

stat()
{
    if [ $1 -eq 0 ]; then
        echo -e "\e[32m Success\e[0m"
    else
        echo -e "\e[33m Failure\e[0m"
    fi
}



echo -e "\e[32m________$COMPONENT Configuration Started_________\e[0m"

echo -n "Installing Ngnix: "
yum install nginx -y &>> Logfile
stat $?
