#!bin/bash
set -e
source LinuxShellPractice/generic.sh
COMPONENT=redis
echo -n "$COMPONENT setup repo : "
curl -s -L -o /etc/yum.repos.d/${COMPONENT}.repo https://raw.githubusercontent.com/stans-robot-project/${COMPONENT}/main/redis.repo 
CheckTheStatus $?

ComponentInstall redis-6.2.7

echo -n "Updating the $COMPONENT config present in /etc/$COMPONENT.conf:"
if [ -f /etc/$COMPONENT.conf ] ; then
    sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/$COMPONENT.conf
    CheckTheStatus $?
else 
    echo "file [etc/$COMPONENT.conf] not exist "
fi 
if [ -f /etc/redis/$COMPONENT.conf ] ; then
echo -n "Updating the $COMPONENT config present in /etc/redis/$COMPONENT.conf :"
sed -i -e 's/127.0.0.1/0.0.0.0/' /etc/redis/$COMPONENT.conf
else 
    echo "file [etc/$COMPONENT.conf] not exist "
fi
CheckTheStatus $?

ServiceStart redis