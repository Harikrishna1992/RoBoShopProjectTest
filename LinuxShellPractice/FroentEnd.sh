#!/bin/bash

set -e

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

echo  "Downloading the front end content"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/frontend/archive/main.zip" &>> $LOG

if [ $? -eq 0 ] ; then
echo -e "\e[33m $FRONTENDSERVICE is Sucess\e[0m"
else
echo -e "\e[31m $FRONTENDSERVICE is failure\e[0m"
fi



CheckTheStatus()
{
    if [ $1 -eq 0 ] ; then
    echo -e "\e[33m Sucess\e[0m"
    else
    echo -e "\e[31m failure\e[0m"
    fi
}
echo -n "remove the content of nginx before deploy the nginx : "
rm -rf "/usr/share/nginx/html/*" &>> $LOG
 CheckTheStatus $?

echo -n "unziping the $Component content into /tmp/$Component.zip"

unzip /tmp/$Component.zip -o -q &>> $LOG

CheckTheStatus $?
cd /usr/share/nginx/html &>> $LOG
mv /tmp/$Component-main/* .&>> $LOG
mv static/* . &>> $LOG
rm -rf frontend-main README.md &>> $LOG
mv localhost.conf /etc/nginx/default.d/roboshop.conf &>> $LOG

echo -n "$FrontEndService is enabled"
systemctl enable $FrontEndService &>> $LOG
CheckTheStatus $?
if [$? -eq 0] ; then
echo -e "\e[32m $FrontEndService is Sucess\e[0m"
else
echo -e "\e[31m $FrontEndService is failure\e[0m"
fi
echo -n "$FrontEndService is restarted"
Systemctl restart $FrontEndService &>> $LOG
CheckTheStatus $?
