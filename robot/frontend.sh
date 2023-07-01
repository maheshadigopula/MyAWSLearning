#!/bin/bash

COMPONENT=frontend


source=common.sh

yum install nginx -y &>> /tmp/${COMPONENT}.log
systemctl enable nginx
systemctl start nginx