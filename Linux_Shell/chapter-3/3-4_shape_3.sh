#!/bin/bash

for ((i=1;i<=5;i++))
do
	for((j=1;j<=i;j++))
	do
		echo -ne "\e[46m  \e[0m"
	done
	echo
done
for ((i=4;i>=1;i--))
do
	for((j=i;j>=1;j--))
	do
		echo -ne "\e[46m  \e[0m"
	done
	echo
done
