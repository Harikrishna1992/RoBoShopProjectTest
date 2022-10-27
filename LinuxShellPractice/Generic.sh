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
    echo -n "Installing the $@ is : "
    yum install -y $@ &>> $LOG
    CheckTheStatus $? 
}

ServiceStart()
{
    echo -n "$# is enabled : "
    systemctl enable $# &>> $LOG
    CheckTheStatus $?

    echo -n "$# is started : "
    systemctl start $# &>> $LOG
    CheckTheStatus $?
}

