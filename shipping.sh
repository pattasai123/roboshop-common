#!/bin/bash

source ./common.sh
pwd=$PWD
appname=shipping
verify_user

dnf install maven -y  &>> $filename
validate $? "installing maven"
system_user

app_setup
cd /app
mvn clean package &>> $filename
mv target/shipping-1.0.jar shipping.jar &>> $filename
system_desetup
app_start

dnf install mysql -y &>> $filename
validate $? "installing mysql"

mysql -h mysql.bongu.online -uroot -pRoboShop@1 "use mysql"
if [ $? -ne 0 ]; then
    mysql -h mysql.bongu.online -uroot -pRoboShop@1 < /app/db/schema.sql
    mysql -h mysql.bongu.online -uroot -pRoboShop@1 < /app/db/app-user.sql 
    mysql -h mysql.bongu.online -uroot -pRoboShop@1 < /app/db/master-data.sql
else
    echo -e "$r we are skipping because shipping data is already there"
fi

app_restart