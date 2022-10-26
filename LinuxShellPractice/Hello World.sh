#! /bin/sh
#! /bin/bash

echo "Hello World"

echo -e "\e[32m hello world \e[0m"
echo -e "\e[33m I am printing Yellow \e[0m"
echo -n "Hello World :"
$!

Name = Hari
Readonly Name
Name = Hari P

echo "$name"
Test = testing
unset Test
echo "$Test"

#$0 File name of script
for arg in $*;do
echo "print $arg"

done

TODAY_DATE="$(date +%F)"
NO_OF_USERS="$(who | wc -l)"

Today_Date = "$(date) + %F)"


echo "The word you entered is: $word" 

VarE = $((3+9))
echo $VarE
touch /tmp/testfile.txt 
var=`df -h | grep tmpfs`
echo $var