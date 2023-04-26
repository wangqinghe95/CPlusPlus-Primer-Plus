#!/bin/bash

nginx="/data/server/nginx/sbin/nginx"
pidfile="/data/server/nginx/logs/nginx.pid"

case $1 in
start)
	if [ -f $pidfile ];then
		echo -e "\e[91mNginx is already running...\e[0m"
		exit
	else
		$nginx && echo -e "\e[32mNginx is already running...\e[0m"
	fi;;
stop)
	if [ -f $pidfile ];then
		echo -e "\e[91mNginx is already stopped.\e[0m"
		exit
	else
		$nginx && echo -e "\e[32mNginx is already stopped.\e[0m"
	fi;;
restart)
	if [ -f $pidfile ];then
		echo -e "\e[91mNginx is already stopped.\e[0m"
		echo -e "\e[91mPlease to run Nginx first.\e[0m"
		exit
	else
		$nginx -s stop && echo -e "\e[32mNginx is already stopped.\e[0m"
	fi
	$nginx && echo -e "\e[32mNginx is running...\e[0m";;
reload)
	if [ -f $pidfile ];then
		echo -e "\e[91mNginx is already stopped.\e[0m"
		exit
	else
		$nginx -s reload && echo -e "\e[32Reload configure done.\e[0m"
	fi;;
*)
	echo "Usage:$0 {start|stop|restart|status|reload}";;
esac
	
