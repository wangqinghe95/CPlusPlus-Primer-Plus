#!/bin/bash

num=10
net="10.0.2"
pipefile="/tmp/multiping_$$.tmp"

multi_ping(){
	ping -c2 -i0.2 -W1 $1 &>/dev/null
	if [ $? -eq 0 ];then
		echo "$1 is up"
	else 
		echo "$1 is down"
	fi
}

mkfifo $pipefile
exec 12<>$pipefile
for i in `seq $num`
do
	echo "" >&12 &
done

for j in {1..254}
do
	read -u12
	{
		multi_ping $net.$j
		echo "" >&12
	} &
done
wait
rm -rf $pipefile
