#!/bin/bash

source ./common.sh
appname=user
pwd=$PWD
verify_user
app_setup
nodejs_setup
cp $pwd/user.service /etc/systemd/system/user.service
system_desetup

app_restart