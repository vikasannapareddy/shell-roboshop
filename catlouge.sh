#!bin/bash
USERID=$(id -u)
# Check if the script is run as root

R="\e[31m"
# red color
G="\e[32m"
# green color
Y="\e[33m"
# yellow color
B="\e[34m"
# blue color
M="\e[35m"
# magenta color
C="\e[36m"
# cyan color
W="\e[37m"
# white color
N="\e[0m"
# no color

LOGS_FOLDER="/var/log/roboshop-logs"
# Check if the logs folder exists
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
# Get the script name without extension
LOG_FILE="${LOGS_FOLDER}/${SCRIPT_NAME}.log"
# Log file path
SCRIPT_DIR=$PWD
# Current working directory

mkdir -p $LOGS_FOLDER
echo "script started executing at: $(date)" | tee -a $LOG_FILE

if [ $USERID -ne 0 ]; then
  echo -e "$R ERROR:: Please run this script with root accesss $N" | tee -a $LOG_FILE
  exit 1
else
    echo "you are running with root access" | tee -a $LOG_FILE

fi

VALIDATE(){
    if [ $1 -eq 0 ]
    then
        echo -e "$2 is ... $G SUCCESS $N" | tee -a $LOG_FILE
        #
    else
        echo -e "$2 is ... $R FAILURE $N" | tee -a $LOG_FILE
    fi
}
dnf module disable nodejs -y &>>$LOG_FILE
VALIDATE $? "Disabling NodeJS module"

dnf module enable nodejs:20 -y &>>$LOG_FILE
VALIDATE $? "Enabling NodeJS:20 module"

dnf install nodejs -y &>>$LOG_FILE
VALIDATE $? "Installing NodeJS:20"