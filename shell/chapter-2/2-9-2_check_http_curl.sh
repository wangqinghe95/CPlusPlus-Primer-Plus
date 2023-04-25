#!/bin/bash

url=http://192.168.4.5/index.html
date=$(date +"%Y-%m-%d %H:%M:%S")
status_code=$(curl -m 3 -s -o /dev/null -w %{http_code} $url)
mail_to="675072584@qq.com"
mail_subject="http_warning"

if [ $status_code -ne 200 ];then
	echo -e "date: $date \t
	$url page error	\t
	status code: $status_code "
	
else
	echo "url access successfully"
fi
