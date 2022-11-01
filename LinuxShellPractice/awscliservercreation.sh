#!bin/bash
set -e
COMPONENT=$1
if [ -z "$1" ];then
echo "Please pass argument to $0 for creating webserver \n\t eg. $0 Frontend"
exit 1
fi
AMIID="$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq '.Images[].ImageId' |sed -e's/"//g')"
echo $AMIID
securitygroup=aws ec2 describe-security-groups --filters Name=group-name,Values=Test-Allow-All | jq '.SecurityGroups[].GroupId' | sed 's\"\\g'
  echo $securitygroup  
aws ec2 run-instances --image-id $AMIID --instance-type t2.micro --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=$COMPONENT}]" --security-group-ids $securitygroup | jq