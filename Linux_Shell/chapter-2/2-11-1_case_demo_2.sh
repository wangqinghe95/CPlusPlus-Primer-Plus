#!/bin/bash

read -p "please input a char from a to z: " key
case $key in
a)
	echo "I'm a.";;&
b)
	echo "I'm b.";;
a)
	echo "I'm aa.";&
c)
	echo "I'm c.";;
a)
	echo "I'm aaa";;
*)
	echo "Out of range";;
esac
