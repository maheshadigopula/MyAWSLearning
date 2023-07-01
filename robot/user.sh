#!/bin/bash

COMPONENT=user
source robot/common.sh

echo -e "\e[33m______ $COMPONENT Configuration Started _________ \e[0m"


echo -n ""
curl --silent --location https://rpm.nodesource.com/setup_16.x | sudo bash -
yum install nodejs -y