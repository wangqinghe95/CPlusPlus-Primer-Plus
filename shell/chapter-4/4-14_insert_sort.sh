#!/bin/bash

#num=(5 3 8 4 7) 
for x in {1..5}
do
	read -p "please input a random: " tmp
	num[$x]=$tmp
done
for ((i=2;i<=5;++i))
do
	tmp=${num[i]}
	for ((j=$[i-1];j>=0 && $tmp<num[j];j--))
	do
		num[j+1]=${num[j]}
		num[j]=$tmp
	done
done

echo ${num[@]}
