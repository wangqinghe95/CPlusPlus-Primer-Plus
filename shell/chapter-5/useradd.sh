#!/bin/bash

read -p "Please input account's name: " username
username=${username:?"The account name was not entered, please try again: "}

read -p "Please input the password, the default is [123456]:" password
password=${password:-123456}

if id $username &> /dev/null ;then
	echo "Account:$username have existed"
else
	sudo useradd $username
	echo "$password" | sudo chpasswd $username &> /dev/null
	echo -e "\e[32m[OK]\e[0m"
fi
