#!/bin/bash

num=(2 8 3 7 1 4 3 2 4 7 4 2 5 1 8 5 2 1 9)

max=${num[0]}
for i in `seq $[${#num[@]}-1]`
do
	[ ${num[i]} -gt $max ] && max=${num[i]}
done


for i in `seq 0 $max`
do
	count[$i]=0
done

for i in `seq 0 $[${#num[@]}-1]`
do
	let count[${num[i]}]++
done

for i in `seq 0 $[${#count[@]}-1]`
do
	for j in `seq ${count[i]}`
	do
		echo -n "$i "
	done
done
echo
