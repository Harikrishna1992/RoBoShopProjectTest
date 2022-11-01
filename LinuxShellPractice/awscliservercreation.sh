#!bin/bash

AMIID = "$(aws ec2 describe-images --filters Name=name,Values=DevOps-LabImage-CentOS7 | jq .Images[].ImageId |sed -e's/"//g')"

echo $AMIID

aws ec2 run-instances --image-id $AMIID --instance-type t2.micro --tag-specifications 'ResourceType=instance,Tags=[{Key=webserver,Value=production}]'