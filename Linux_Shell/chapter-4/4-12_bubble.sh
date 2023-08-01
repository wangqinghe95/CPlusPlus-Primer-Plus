#!/bin/bash

for i in {1..6}
do
	read -p "Please input a number: " tmp
	if echo $tmp | grep -qP "\D"; then
		echo "The input is not number"
		exit
	fi
	num[$i]=$tmp
done
echo "the number you input is: ${num[@]}"

for ((i=1;i<=5;i++))
do
	for ((j=1;j<=$[6-i];j++))
	do
		if [ ${num[j]} -gt ${num[j+1]} ];then
			tmp=${num[j]}
			num[$j]=${num[j+1]}
			num[j+1]=$tmp
		fi
	done
done
echo "After sort, the seq of num is : ${num[@]}"
