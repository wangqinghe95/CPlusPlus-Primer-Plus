#!/bin/bash

echo "Please select one item according to the prompt"
select item in "CPU" "IP" "MEM" "exit"
do
	case $item in
	"CPU")
		uptime;;
	"IP")
		ip a s;;
	"MEM")
		free;;
	"exit")
		exit;;
	*)
		echo error;;
	esac
done
