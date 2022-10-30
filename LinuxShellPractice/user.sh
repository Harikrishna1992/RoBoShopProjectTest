#!bin/bash
set -e
source /LinuxShellPractice/generic.sh
COMPONENT=user
APPUSER=roboshop
echo -n "Downloading the Node js service : "
curl -sL https://rpm.nodesource.com/setup_lts.x | bash &>> $LOG
CheckTheStatus $?

ComponentInstall nodejs
#Creating user
UserCreation

AppContantRemove

echo "navigating to /home/$APPUSER"
cd /home/$APPUSER &>> $LOG

#Download the content
echo -n "Downloading the content : "
curl -s -L -o /tmp/$COMPONENT.zip "https://github.com/stans-robot-project/$COMPONENT/archive/main.zip" &>> $LOG
CheckTheStatus $?

unzipContent

#Move the data
mv -f $COMPONENT-main $COMPONENT &>> $LOG
cd /home/$APPUSER/$COMPONENT &>> $LOG
echo -n "Npm Installation : "
npm install &>> $LOG
CheckTheStatus $?


ApplyOwnerShipAndExecutePermission

echo -n "configuring the systemD file with MongoDB server IP : "
sed -i -e 's/MONGO_DNSNAME/172.31.86.195/' /home/$APPUSER/$COMPONENT/systemd.service &>> $LOG
CheckTheStatus $?

echo -n "Moving mongoDB service file to default System file location : "
mv /home/$APPUSER/$COMPONENT/systemd.service /etc/systemd/system/$COMPONENT.service &>> $LOG
CheckTheStatus $?

ServiceStart catalogue