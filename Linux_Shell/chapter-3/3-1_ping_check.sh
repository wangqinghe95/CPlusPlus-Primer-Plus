#!/bin/bash

net="10.0.2"
#for i in {1..254}
for i in $(seq 254) 
do 
	ping -c2 -i0.2 -Wl $net.$i &>/dev/null
	if [ $? -eq 0 ];then
		echo "$net.$i is up"
	else
		echo "$net.$i is down"
	fi
done
