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

if [ $? -ne 0 ] ; then
    echo -n "Creating the $APPUSER user :"
    useradd $APPUSER &>> $LOG
    CheckTheStatus $?
else
  echo "user $APPUSER is already exist"
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
mv $COMPONENT-main $COMPONENT &>> $LOG
cd /home/$APPUSER/$COMPONENT &>> $LOG
echo -n "Npm Installation : "
npm install &>> $LOG
CheckTheStatus $?

echo -n "Changing ownership to $APPUSER: "
chown -R $APPUSER:$APPUSER /home/$APPUSER/$COMPONENT &&  chmod -R 775 /home/$APPUSER/$COMPONENT 
CheckTheStatus $?








