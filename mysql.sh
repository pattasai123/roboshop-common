#!/bin/bash
source ./common.sh
verify_user
dnf install mysql-server -y &>> $filename
validate $? "Installing mysql"
systemctl enable mysqld &>> $filename
validate $? "Enableing mysql"
systemctl start mysqld &>> $filename
validate $? "Starting mysql"
mysql_secure_installation --set-root-pass RoboShop@1