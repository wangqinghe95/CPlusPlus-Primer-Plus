#!/bin/bash

shopt -s extglob
read -p "please input a any character: " key
case $key in
+([Yy]))
	echo "The input one more [Yy]";;
?([Nn])o)
	echo "The input is [Nn]o or O";;
t*(o))
	echo "The input is t or to or too...";;
@([0-9]))
	echo "The input is a digit";;
!([[:punct:]]))
	echo "The input is not punct";;
*)
	echo "The input is other character";;
esac
