#!/bin/bash

num=(5 3 8 4 7 9 2)
quick_sort(){
	if [ $1 -ge $2 ];then
		return
	fi
	local base=${num[$1]}
	local left=$1
	local right=$2

	while [ $left -lt $right ]
	do
		while [[ ${num[right]} -ge $base && $left -lt $right ]]
		do
			let right--
		done

		while [[ ${num[left]} -le $base && $left -lt $right ]]
		do
			let left++
		done

		if [ $left -lt $right ]; then
			local tmp=${num[$left]}
			num[$left]=${num[right]}
			num[$right]=$tmp
		fi
	done
	
	num[$1]=${num[left]}
	num[left]=$base
	quick_sort $1 $[left-1]
	quick_sort $[left+1] $2
}

quick_sort 0 ${#num[@]}
echo ${num[*]}
