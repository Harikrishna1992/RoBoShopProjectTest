#!/bin/sh

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

echo $*   # Gives you all the arguments used in the script
echo $@   # Gives you all the arguments used in the script
echo $#   # Gves you the number of arguments users
echo $$   # Gives you the PID of the current process
echo $?   # Gives you the exit code the previous command
echo -e "Hi, please type the word: \c "
read  word
echo "The word you entered is: $word" 


echo $name