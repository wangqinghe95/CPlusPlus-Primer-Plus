#!/bin/bash

for i in $(seq 6)
do
	for j in $(seq $i)
	do
		echo -ne "\e[101m \e[0m"
	done
	echo
done
