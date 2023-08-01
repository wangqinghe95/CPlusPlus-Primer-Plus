#!/bin/bash

clear
num=$[RANDOM%10+1]
read -p "please input a number from 1~10: " guess_num

if [ $guess_num -eq $num ];then
	echo "Congratulation, you are right: $num"
elif [ $guess_num -lt $num ];then
	echo "Ooops, guess too small"
else
	echo "Ooops, guess to big"
fi
