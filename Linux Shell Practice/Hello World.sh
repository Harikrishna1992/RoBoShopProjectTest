#!/bin/sh

echo "Hello World"

echo -e "\e[32m hello world \e[0m"
echo -e "\e[33m I am printing Yellow \e[0m"
echo -n "Hello World :"
$!

Name = $1

echo -e "Hi, please type the word: \c "
read  word
echo "The word you entered is: $word" 


echo $name