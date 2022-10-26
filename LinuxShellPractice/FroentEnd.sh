#!/bin/bash

set -e
CheckTheStatus()
{
    if [ $1 -eq 0 ] ; then
    echo -e "\e[33m Sucess\e[0m"
    else
    echo -e "\e[31m failure\e[0m"
    fi
}

USERID=$(id -u) 

# User Validation ; Checks whether the user is a root user or not.
if [ $USERID -ne 0 ]  ; then 
    echo -e "\e[31m You must run this script as a root user or with sudo privilege \e[0m"
    exit 1
fi 
COMPONENT=frontend
LOG=/tmp/$COMPONENT.log

#Installing  the nginx
FRONTENDSERVICE=nginx
echo "Stated the installation of $FRONTENDSERVICE"
yum install $FRONTENDSERVICE -y &>> $LOG

#if [$? -eq 0];then
if [ $? -eq 0 ]; then
echo  -e "\e[32m Installation of $FRONTENDSERVICE is Sucess\e[0m"
else
echo -e "\e[31m installation of $FRONTENDSERVICE is failure\e[0m"
fi

#Remove zip file if exists
if [ -f /tmp/$COMPONENT.zip ] ; then
echo -n "removing $COMPONENT.zip if exit"
fi
rm -rf /tmp/$COMPONENT.zip 
echo  "Downloading the front end content"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/frontend/archive/main.zip" &>> $LOG

if [ $? -eq 0 ] ; then
echo -e "\e[33m $COMPONENT extracted is Sucess\e[0m"
else
echo -e "\e[31m $COMPONENT extracted is failure\e[0m"
fi


echo -n "remove the content of nginx before deploy the nginx : "
rm -rf "/usr/share/nginx/html/*" &>> $LOG
CheckTheStatus $?

cd /usr/share/nginx/html 
echo -n "unziping the $COMPONENT content into /tmp/$COMPONENT.zip : "
unzip /tmp/$COMPONENT.zip &>> $LOG
CheckTheStatus $?


mv /tmp/$COMPONENT-main/* .
mv static/* . &>> $LOG
rm -rf frontend-main README.md &>> $LOG
mv localhost.conf /etc/nginx/default.d/roboshop.conf &>> $LOG

echo -n "$FRONTENDSERVICE is enabled : "
systemctl enable $FRONTENDSERVICE &>> $LOG
CheckTheStatus $?

echo -n "$FRONTENDSERVICE is started : "
systemctl start $FRONTENDSERVICE &>> $LOG
CheckTheStatus $?
