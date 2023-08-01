#!/bin/bash

for((i=1;i<=9;++i))
do
	for((j=1;j<=i;j++))
	do
		echo -n "$i*$j=$[i*j] "
	done
	echo
done
