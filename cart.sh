#!/bin/bash

source ./common.sh
appname=cart
pwd=$PWD
verify_user
system_user
app_setup
nodejs_setup
system_desetup

app_restart