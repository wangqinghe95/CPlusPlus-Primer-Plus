#!/bin/bash

if [ -z "$1" ]; then
	echo -n "usage : script "
	echo -e "\e[32m domain or IP : \e[0m"
	exit
fi

ping -c2 -i1 -W1 "$1" &>/dev/null
if [ $? -eq 0 ]; then
	echo "$1 is up"
else
	echo "$1 is down"
fi
