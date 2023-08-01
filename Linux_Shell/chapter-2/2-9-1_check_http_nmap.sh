#!/bin/bash
ip=192.168.56.1
mail_to=luis.wang@aptiv.com

nmap -n -sS -p80 $ip | grep -q "^80/tcp open"
if [ $? -eq 0 ];then
	echo "http service is running on $ip" | mail -s http_status_OK $mail_to
else
	echo "http service is stoped on $ip" | mail -s http_status_error $mail_to
fi
