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
