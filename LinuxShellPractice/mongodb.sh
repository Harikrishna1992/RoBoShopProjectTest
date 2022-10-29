#!/bin/bash

set -e 

COMPONENT=mongodb

source LinuxShellPractice/generic.sh

echo -n "mongodb setup repo : "
curl -s -o /etc/yum.repos.d/${COMPONENT}.repo https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/mongo.repo 
CheckTheStatus $?

#Installing the mongodb component
 echo -n "Installing the $COMPONENT is : "
 yum install -y $COMPONENT-org &>> $LOG
 CheckTheStatus $? 

#Updating the lisener IP address for mangodb
echo -n "Updating the mongodb config :"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/$COMPONENT.conf
CheckTheStatus $?

#Start the mangodb service
ServiceStart $COMPONENT

echo -n "Downloading the $COMPONENT Schema:"
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/mongodb/archive/main.zip" &>> $LOG
CheckTheStatus $?

cd /tmp
unzip -o $COMPONENT.zip &>> $LOG
mv $COMPONENT-main/* .  &>> $LOG
cd $COMPONENT-main &>> $LOG
mango < catalogue.js &>> $LOG
mongo < users.js &>> $LOG



