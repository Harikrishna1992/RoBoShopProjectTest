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

LOG=/tmp/$COMPONENT.log

ComponentInstall()
{
    echo -n "Installing the $1 is : "
    yum install -y $1 &>> $LOG
    CheckTheStatus $? 
}

UserCreation()
{
#Create user
id $APPUSER &>> $LOG

if [ $? -ne 0 ] ; then
    echo -n "Creating the $APPUSER user :"
    useradd $APPUSER &>> $LOG
    CheckTheStatus $?
else
  echo "user $APPUSER is already exist"
fi
}
ServiceStart()
{
    systemctl daemon-reload &>> $LOG
    echo -n "$1 service is enabled : "
    systemctl enable $1 &>> $LOG
    CheckTheStatus $?

    echo -n "$1 service is started : "
    systemctl start $1 &>> $LOG
    CheckTheStatus $?
}

AppContantRemove()
{
#remove the the content zip file if exist from Appuser location
echo "removing application content before extracting if exits [/home/$APPUSER/tmp/$COMPONENT.zip] "
rm -rf /home/$APPUSER/tmp/$COMPONENT.zip &>> $LOG
echo "removing application content folder if exits [/home/$APPUSER/tmp/$COMPONENT]"
rm -rf /home/$APPUSER/$COMPONENT &>> $LOG
}
unzipContent()
{
    #unzip the contant
echo -n "Unzipping the $COMPONENT.zip : "
unzip -o /tmp/$COMPONENT.zip &>> $LOG
CheckTheStatus $?

}

ApplyOwnerShipAndExecutePermission (){
echo -n "Changing ownership to $APPUSER: "
chown -R $APPUSER:$APPUSER /home/$APPUSER/$COMPONENT
CheckTheStatus $?
echo -n "Adding execute permission to folder /home/$APPUSER/$COMPONENT : "
chmod -R 775 /home/$APPUSER/$COMPONENT
CheckTheStatus $?
}
