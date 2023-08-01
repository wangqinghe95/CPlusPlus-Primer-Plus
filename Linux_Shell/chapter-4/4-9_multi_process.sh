#!/bin/bash

pipefile="/tmp/procs_$$.tmp"
mkfifo $pipefile

exec 12<>$pipefile

for i in {1..5}
do
	echo "" >&12 &
done

for j in {1..20}
do
	read -u12
	{
		echo -e "\e[32mstart sleep No.$j\e[0m"
		sleep 5
		echo -e "\e[32mstop sleep No.$j\e[0m"
		echo "" >&12
	} &
done
wait
rm -rf $pipefile
	
