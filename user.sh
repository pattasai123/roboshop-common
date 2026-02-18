#!/bin/bash

source ./common.sh
appname=user
pwd=$PWD
verify_user
system_user
app_setup
nodejs_setup
system_desetup
app_restart

