#!/bin/bash
# description: monitor service's status
if [ -z $1 ];then
	echo "error : No input service name"
	echo "usage : script_name service_name"
	exit
fi

if systemctl is-active $1 &>/dev/null ;then
	echo "$1 have started"
else 
	echo "$1 have not started"
fi

if systemctl is-enable $1 &>/dev/null ;then
	echo "$1 is boot from start-up item"
else
	echo "$1 is not boot from start-up item"
fi
