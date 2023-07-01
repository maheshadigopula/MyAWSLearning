#!/bin/bash

COMPONENT=frontend


source=common.sh

yum install nginx -y
systemctl enable nginx
systemctl start nginx