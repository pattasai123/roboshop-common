#!/bin/bash
source ./common.sh
pwd=$PWD
appname=payment
verify_user
dnf install python3 gcc python3-devel -y &>/dev/null
validate $? "installing python3"
system_user
app_setup
cd /app 
pip3 install -r requirements.txt&>> $filename
system_desetup
app_start