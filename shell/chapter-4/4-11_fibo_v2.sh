#!/bin/bash

Fibonacci(){
	if [[ $1 -eq 1 || $1 -eq 2 ]];then
		echo -n "1 "
	else
		echo -n "$[$(Fibonacci $[$1-1])+$(Fibonacci $[$1-2])] "
	fi
}

for i in {1..10}
do
	Fibonacci $i
done
echo
