#!/bin/bash

source ./common.sh
appname=catalouge
pwd=$PWD
verify_user
app_setup
nodejs_setup
system_desetup

cp $pwd/mongo.repo /etc/yum.repos.d/mongo.repo

dnf install mongodb-mongosh -y &>> $filename

index=$(mongosh mongodb.bongu.online --quiet --eval "db.getMongo().getDBNames().indexOf('catalogue')")
if [ $? -le 0 ];then 
    mongosh --host mongodb.bongu.online </app/db/master-data.js &>> $filename
else
    echo -e "$g we are skiping already exit "
fi

app_restart