#!/bin/bash

DATE=$(date +%F)
LOGSDIR=/tmp
SCRIPT_NAME=$0
LOGFILE=$(LOGSDIR)/$(SCRIPT_NAME)_$(DATE).log
USERID=$(id -u)

R="\e[31m"
G="\e[32m"
N="\e[0m"
Y="\e[33m"


if [ $USERID -ne 0 ];
then
    echo -e " $R please run with root user $N"
    exit 1
fi

VALIDATE(){
    if [ $1 -ne 0 ];
    then
        echo -e "$2.... $R FAILURE $N"
        exit 1
    else
        echo -e "$2.... $G SUCCESS $N"
    fi
}

yum install nginx -y &>>$LOGFILE

VALIDATE $? "INSTALLING NGINX"

systemctl enable nginx &>>LOGFILE

VALIDATE &? "ENABLING NGINX"

systemctl start nginx &>>LOGFILE

VALIDATE $? "STARTING NGINX"

rm -rf /usr/share/nginx/html/* &>>LOGFILE

VALIDATE $? "removing default index.html files"

curl -o /tmp/web.zip https://roboshop-builds.s3.amazonaws.com/web.zip &>>LOGFILE

VALIDATE $? "Downloading web Artifact"

cd /usr/share/nginx/html &>>LOGFILE

VALIDATE $? "moviing to default html directory"

unzip /tmp/web.zip &>>LOGFILE

VALIDATE $? "unzipping the artifact in html folder"

cp /home/centos/newcripts/roboshop.conf /etc/nginx/default.d/roboshop.conf &>>LOGFILE

VALIDATE $? "cpoying roboshop config"

systemctl restart nginx  &>>$LOGFILE

VALIDATE $? "Restarting Nginx"