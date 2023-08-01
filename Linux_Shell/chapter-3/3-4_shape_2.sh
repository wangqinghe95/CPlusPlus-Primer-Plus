#!/bin/bash

for ((i=1;i<=6;++i))
do
	for((j=6;j>=i;j--))
	do
		echo -ne "\e[46m \e[0m"
	done
	echo
done
