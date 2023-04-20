#!/bin/bash
# version 0.2

read -p "please input user name : " user
read -s -p "please input password : " passwd
# if [[ ! -z "$user" && ! -z "$passwd" ]];then
# if [ ! -z "$user" ] && [ ! -z "$passwd" ];then
if [ ! -z "$user" -a ! -z "$passwd" ];then
	useradd "$user"
	echo -e "$passwd\n$passwd" | passwd "$user"
fi