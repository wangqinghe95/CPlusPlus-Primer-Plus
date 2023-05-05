#!/bin/bash

for i in {2000..2500}
do
	if [[ $[i%4] -eq 0 && $[i%100] -ne 0 || $[i%400] -eq 0 ]];then
		echo "$i is leap year"
	else
		echo "$i not leap year"
	fi
done
