#!/bin/bash

source ./common.sh

verify_user
pwd=$PWD

cp $pwd/rabbitmq.repo /etc/yum.repos.d/rabbitmq.repo
dnf install rabbitmq-server -y &>> $filename
validate $? "Installing rabbit-server"
systemctl enable rabbitmq-server &>> $filename
validate $? "Enableing rabbit-server"
systemctl start rabbitmq-server &>> $filename
validate $? "Starting rabbit-server"
rabbitmqctl add_user roboshop roboshop123
rabbitmqctl set_permissions -p / roboshop ".*" ".*" ".*"