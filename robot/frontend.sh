#!/bin/bash

COMPONENT=frontend


source=common.sh

yum install nginx -y &>> /tmp/frontend.log
systemctl enable nginx
systemctl start nginx