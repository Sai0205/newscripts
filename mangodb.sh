#!/bin/bash


DATE=$(date)
LOGDIR=/tmp
FILENAME=$0
LOGFILE=$LOGDIR/${FILENAME}_$DATE.log
USERID=$(id -u)

if [ $USERID -ne 0 ];
    then
        echo "you are not a super user"
        exit 1
fi


VALIDATE(){
    if [ $1 -ne 0 ]
    then
        echo "$2 failed"
        exit 1
    else
        echo "$2 success"
    fi 
}

cp /home/centos/newscripts /etc/yum.repos.d/mango.repo &>>LOGFILE

VALIDATE $? "copying mango repo content " 

yum install mongodb-org -y &>>LOGFILE

VALIDATE $? "installing mongodb"

systemctl enable mongod &>>LOGFILE

VALIDATE $? "enabling mangodb"

systemctl start mongodb &>>LOGFILE

VALIDATE $? "starting mangodb"

sed -i 's/127.0.0.1/0.0.0.0/' /etc/mongod.conf &>> $LOGFILE

VALIDATE $? "Edited MongoDB conf"

systemctl restart mongod &>> $LOGFILE

VALIDATE $? "Restarting MonogoDB"
