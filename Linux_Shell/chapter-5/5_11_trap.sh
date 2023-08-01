#!/bin/bash

trap 'echo "No interupt | sleep"; sleep 3' INT TSTP
trap 'echo Test; sleep 3' HUP

while :
do
	echo "signal"
	echo "demo"
done
