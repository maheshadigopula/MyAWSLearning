#!/bin/bash

COMPONENT=frontend
LOGFILE= /tmp/$COMPONENT.log

yum install nginx -y 
systemctl enable nginx
systemctl start nginx