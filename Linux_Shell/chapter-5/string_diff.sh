#!/bin/bash

echo "-----------------------------------"
echo -e "\e[32m * is regarded as a whole, and circle one time.\e[0m"

for i in "${!U*}"
do
	echo "Variation is $i"
done
echo
echo "-----------------------------------"
echo -e "\e[32m @ is regarded as individual word, and circle n times.\e[0m"
for i in "${!U@}"
do
	echo "Variation is $i"
done
 echo "-----------------------------------"
