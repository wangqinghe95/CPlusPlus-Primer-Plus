#!/bin/bash

net="10.0.2"
multi_ping(){
	ping -c2 -i0.2 -W1 $1 &>/dev/null
	if [ $? -eq 0 ];then
		echo "$1 is up"
	else
		echo "$1 is down"
	fi
}


for i in {1..254}
do
	multi_ping $net.$i &
done
wait
