#!/bin/bash

num=$[RANDOM%100]
count=0
while :
do
	read -p "please guess a num from 1 to 100: " guess
	[[ $guess =~ [[:alpha:]] || $guess =~ [[:punct:]] ]] && echo "Invalid input" && exit
	let count++
	if [ $guess -eq $num ];then
		echo "Congratualtion! you are right, and the num you guess is $count"
		exit
	elif [ $guess -gt $num ];then
		echo "Oops, too big"
	else
		echo "Oops, too small"
	fi
done
