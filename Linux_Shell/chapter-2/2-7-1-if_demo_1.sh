#!/bin/bash
# version 0.2

read -p "please input user name : " user
read -s -p "please input password : " passwd
if [ ! -z "$user" ];then
	if [ ! -z "$passwd" ]; then
		useradd "$user"
		echo "$passwd" | passwd --stdin "$user"
	fi
fi
