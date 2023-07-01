#!/bin/bash

COMPONENT=catalogue
source robot/common.sh
echo -e "\e[33m______ $COMPONENT Configuration Started _________ \e[0m"
NODEJS
CREATE_USER
DOWNLAOD_AND_EXTRACT
NPM_INSTALL
CONFIGURE_SERVICE
















