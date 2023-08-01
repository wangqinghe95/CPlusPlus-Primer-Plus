#!/bin/bash

for i in $(cat user.txt)
#for i in `cat user.txt`
do
	if id $i &>/dev/null ;then
		echo "the count $i is already exist"
	else
		useradd $i
		echo "$i:123456" | sudo chpasswd $i
	fi
done
