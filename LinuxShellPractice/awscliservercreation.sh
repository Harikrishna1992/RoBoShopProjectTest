#!bin/bash

AMIID="$(aws ec2 describe-images --filters "Name=name,Values=DevOps-LabImage-CentOS7" | jq '.Images[].ImageId' |sed -e's/"//g')"
echo $AMIID
securitygroup=aws ec2 describe-security-groups --filters Name=group-name,Values=Test-Allow-All

aws ec2 run-instances --image-id $AMIID --instance-type t2.micro --tag-specifications "ResourceType=instance,Tags=[{Key=Name,Value=Test}]" --security-group-ids $securitygroup