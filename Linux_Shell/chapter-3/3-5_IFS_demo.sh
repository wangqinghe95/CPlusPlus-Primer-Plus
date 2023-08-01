#!/bin/bash

echo -e "\e[32m Undefined IFS \e[0m"
X="a b c d"
for i in $X
do 
	echo "I am $i"
done
echo

OLD_IFS="$IFS"
echo -e "\e[32m custom definition IFS is semicolon \e[0m"
IFS=";"
X="1 2 3 4"
for i in $X
do
	echo "I am $i"
done
echo

echo -e "\e[32m custom definition IFS is semicolon and X splited by semicolon \e[0m"
IFS=";"
X="Jacob;Rose;Vicky;Rick"
for i in $X
do
	echo "I am $i"
done
echo

echo -e "\e[32m custom definition IFS is semicolon,colon and X splited by semicolon \e[0m"
IFS=";.:"
X="Jacob;Rose.Vicky:Rick"
for i in $X
do
	echo "I am $i"
done
echo
