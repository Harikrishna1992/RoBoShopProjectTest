#!/bin/bash

set -e

UserID = $(uname -u)
#Username Validation ; Check user is root or not
if[$UserID -ne 0];then
echo -e "\e[31m user must be a root user or having sudo previlages\e[0m"
exit 1
fi
Component = FrontEnd
Log = /tmp/$Component.log

#Installing  the nginx
FrontEndService = nginx
echo -n "Stated the installation of $FrontEndService"
yum install $FrontEndService -y &>> $log
$?
if[$? -eq 0] ; then
echo "\e[32m Installation of $FrontEndService is Sucess\e[0m"
else
echo "\e[31m installation of $FrontEndService is failure\e[0m"
fi

echo -n "Downloading the front end content"
curl -s -L -o /tmp/$Component.zip "https://github.com/stans-robot-project/frontend/archive/main.zip" &>> $log
$?
if[$? -eq 0] ; then
echo "\e[33m $FrontEndService is Sucess\e[0m"
else
echo "\e[31m $FrontEndService is failure\e[0m"
fi



CheckTheStatus()
{
    if[$1 -eq 0] ; then
    echo "\e[33m $FrontEndService is Sucess\e[0m"
    else
    echo "\e[31m $FrontEndService is failure\e[0m"
    fi
}
echo -n "remove the content of nginx before deploy the nginx "
rm -rf "/usr/share/nginx/html/*" &>> $log
 CheckTheStatus $?

echo -n "unziping the $Component content into /tmp/$Component.zip"

unzip /tmp/$Component.zip -o -q &>> $log

CheckTheStatus $?
cd /usr/share/nginx/html &>> $log
mv /tmp/$Component-main/* .&>> $log
mv static/* . &>> $log
rm -rf frontend-main README.md &>> $log
mv localhost.conf /etc/nginx/default.d/roboshop.conf &>> $log

echo -n "$FrontEndService is enabled"
systemctl enable $FrontEndService &>> $log
$?
if[$? -eq 0] ; then
echo "\e[32m $FrontEndService is Sucess\e[0m"
else
echo "\e[31m $FrontEndService is failure\e[0m"
fi
echo -n "$FrontEndService is restarted"
Systemctl restart $FrontEndService &>> $log
$?
