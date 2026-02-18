#!/bin/bash

source ./common.sh

verify_user

dnf module disable redis -y &>> $filename
validate $? "disableing redis"
dnf module enable redis:7 -y &>> $filename
validate $? "enable redis"
dnf install redis -y &>> $filename
validate $? "Installing redis"
sed -i -e "s/^bind .*/bind 0.0.0.0/" \
            -e "s/^protected-mode .*/protected-mode no/" \
            /etc/redis/redis.conf

systemctl enable redis &>> $filename
validate $? "Enableing redis"
systemctl start redis  &>> $filename
validate $? "Starting redis"
