#!/bin/bash

url="htpp://192.168.4.5/index.html"
date=$(date +"%Y-%m-%d %H:%M:%S"

source_path="e3eb0a1df437f3f97a64aca5952c8ea0"
url_hash=$(curl -s $url | md5sum | cut -d ' ' -f1)
if [ "$url_hash != "source_path" ];then
	echo -e "date:$(date) \n date check error,$url"
else
	cat >> /var/log/http_check <<- EOF
	echo -e "$url data is complete"
fi
