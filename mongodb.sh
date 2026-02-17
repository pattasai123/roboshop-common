#!/bin/bash

source ./common.sh

verify_user

cp mongo.repo /etc/yum.repos.d/mongo.repo
dnf install mongodb-org -y &>> $filename
validate $? "Installing mongodb"
systemctl enable mongod &>> $filename
validate $? "Enableing mongodb"
systemctl start mongod  &>> $filename
validate $? "Starting mongodb"

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mongod.conf