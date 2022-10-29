#!bin/bash

set -e
APPUSER=roboshop
COMPONENT=catalogue

source LinuxShellPractice/generic.sh

echo -n "Downloading the Node js service : "
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> $LOG
CheckTheStatus $?

#Node Js service install
ComponentInstall nodejs

#Create user
id $APPUSER &>> $LOG

if [ $? -eq 0 ] ; then
echo -n "Creating the $APPUSER user :"
useradd $APPUSER &>> $LOG
CheckTheStatus $?
else
echo "user "${$APPUSER}" is already exit"
fi



#remove the the content zip file if exist from Appuser location
rm -rf /home/$APPUSER/tmp/$COMPONENT.zip &>> $LOG

cd /home/$APPUSER &>> $LOG

#Download the content
echo -n "Downloading the content : "
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip" &>> $LOG
CheckTheStatus $?

#unzip the contant
echo -n "Unzipping the $COMPONENT.zip : "
unzip -o /tmp/$COMPONENT.zip &>> $LOG
CheckTheStatus $?

#Move the data
mv /tmp/$COMPONENT-main $COMPONENT &>> $LOG
cd /home/$APPUSER/$COMPONENT &>> $LOG
npm install &>> $LOG

#if [-f systemd.servce];then
#sed -i -e '/s'
#fi










