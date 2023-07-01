#!/bin/bash

COMPONENT=frontend
LOGFILE= /tmp/$COMPONENT.log

yum install nginx -y    &>> LOGFILE
systemctl enable nginx  &>> LOGFILE
systemctl start nginx   &>> LOGFILE