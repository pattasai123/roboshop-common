#!/bin/bash
source ./common.sh
pwd=$PWD 
appname=dispatch
verify_user
dnf install golang -y &>/dev/null
validate $? "installing golang"
system_user
app_setup
cd /app 
go mod init dispatch &>> $filename
go get &>> $filename 
go build &>> $filename
system_desetup
app_start