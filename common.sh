r="\e[32m"
g="\e[33m"
folder="/var/log/shell_roboshop"
file=$(echo $0| cut -d "." -f1)
filename="$folder/$file.log"
mkdir -p $folder

verify_user(){
    user=$(id -u)
    if [ $user -ne 0 ]; then
        echo "ERROR:: please run this with root access"
        exit 1
    fi
}

validate(){
    if [ $1 -eq 0 ]; then
        echo -e "$2...$r success $g " | tee -a $filename
    else 
        echo -e "$2 ... $r Failure $g " | tee -a $filename
        exit 1
    fi
}

nodejs_setup(){
dnf list installed nodejs &>/dev/null

if [ $? -eq 0 ]; then
    dnf remove nodejs -y &>> $filename
fi
dnf module disable nodejs -y &>> $filename
validate $? "disableing nodejs"

dnf module enable nodejs:20 -y &>> $filename
validate $? "Enableing 20 nodejs"

dnf install nodejs -y  &>/dev/null
validate $? "installing nodejs" 
npm install &>> $filename
}

app_setup(){
    mkdir -p /app 

    curl -o /tmp/$appname.zip https://roboshop-artifacts.s3.amazonaws.com/$appname-v3.zip &>> $filename

    cd /app 
    rm -rf /app/*
    unzip /tmp/$appname.zip &>> $filename
}

system_desetup(){
    cp $pwd/$appname.service /etc/systemd/system/$appname.service

    systemctl daemon-reload &>> $filename
    validate $? "daemon-reload"

    systemctl enable $appname &>> $filename
    validate $? "enable $appname"
}

app_start(){
    systemctl start $appname &>> $filename
    validate $? "start $appname"
}

system_user(){
    id roboshop &>> $filename
    if [ $? -ne 0 ]; then
        useradd --system --home /app --shell /sbin/nologin --comment "roboshop system user" roboshop &>> $filename
    else
        echo -e "$r skipping already exist"
    fi
}

app_restart(){
    systemctl restart $appname &>> $filename
    validate $? "start $appname"
}
