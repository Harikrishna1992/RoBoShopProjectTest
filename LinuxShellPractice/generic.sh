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


ServiceStart()
{
    echo -n "$1 is enabled : "
    systemctl enable $1 &>> $LOG
    CheckTheStatus $?

    echo -n "$# is started : "
    systemctl start $# &>> $LOG
    CheckTheStatus $?
}

