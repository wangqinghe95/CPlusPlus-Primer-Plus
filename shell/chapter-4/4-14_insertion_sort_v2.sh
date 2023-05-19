#!/bin/bash

num=(2 4 7 8 9)

for ((i=1;i<=5;i++))
do
	tmp=${num[i]}
	j=$[i-1]
	while [[ $j -ge 0 && $tmp -lt ${num[j]} ]]
	do
		num[j+1]=${num[j]}
		num[j]=$tmp
		let j--
	done
done
echo ${num[@]}
