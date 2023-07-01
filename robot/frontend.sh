#!/bin/bash

COMPONENT=frontend


source=common.sh

yum install nginx -y &>> /tmp/${COMPONENT}.log
systemctl enable nginx &>> /tmp/${COMPONENT}.log
systemctl start nginx &>> /tmp/${COMPONENT}.log