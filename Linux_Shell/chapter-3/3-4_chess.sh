#!/bin/bash

for i in {1..8}
do
	for j in {1..8}
	do
		sum=$[i+j]
		if [[ $[sum%2] -ne 0 ]];then
			echo -ne "\e[41m  \e[0m"
		else
			echo -ne "\e[47m  \e[0m"
		fi
	done
	echo
done
