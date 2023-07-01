#!/bin/bash

COMPONENT=frontend


source=common.sh

yum install nginx -y &>> $LOGFILE
systemctl enable nginx &>> $LOGFILE
systemctl start nginx &>> $LOGFILE