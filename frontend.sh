#!/bin/bash

source ./common.sh
pwd=$PWD 
appname=nginx
verify_user


dnf list installed nginx &>/dev/null

if [ $? -eq 0 ]; then
    dnf remove nginx -y &>> $filename
fi
dnf module disable nginx -y &>> $filename
validate $? "disableing nginx"

dnf module enable nginx:1.24 -y &>> $filename
validate $? "Enableing 20 nginx"

dnf install nginx -y &>> $filename
validate $? "installing nginx"
systemctl enable nginx &>> $filename
validate $? "enable nginx"
app_start
rm -rf /usr/share/nginx/html/* &>> $filename
curl -o /tmp/frontend.zip https://roboshop-artifacts.s3.amazonaws.com/frontend-v3.zip &>> $filename
cd /usr/share/nginx/html &>> $filename
unzip /tmp/frontend.zip &>> $filename

cp $pwd/nginx.conf /etc/nginx/nginx.conf

app_restart
