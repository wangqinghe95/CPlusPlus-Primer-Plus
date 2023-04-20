#!/bin/bash

setcolor_failure="echo -en \\033[91m"
setcolor_success="echo -ne \\033[32m"
setcolor_normal="echo -e \\033[0m"
nginx_version=/home/user/Downloads/nginx-1.14.0.tar.gz

if [[ $UID -ne 0 ]];then
	$setcolor_failure
	echo -n "please use root to exec this script"
	$setcolor_normal
	exit
else
	echo "$UID"
fi

if [[ ! -f $nginx_version ]];then
	echo "$nginx_version is not exit"
	if which wget;then
		wget -c http://nginx.org/download/nginx-1.14.0.tar.gz -o $nginx_version
	else
		$setcolor_failure
		echo "Wget is not exist, please download wget"
		$setcolor_normal
	fi
else
	echo "The package already exists"
fi

if id nginx &>/dev/null ;then
	adduser -s /sbin/nologin nginx
fi

if [[ -f $nginx_version ]];then
	$setcolor_success
	echo -n "It will spend some time to install nginx!"
	$setcolor_normal
	sleep 1
	tar -xf $nginx_version
	cd nginx-1.14.0/
	./configure \
	--user=nginx \
	--group=nginx \
	--prefix=/data/server/nginx	\
	--with-stream	\
	--with-http_ssl_module	\
	--with-http_stub_status_module	\
	--without-http_autoindex_module	\
	--without-http_ssi_module
	make
	make install
fi

if [[ -x /data/server/nginx/sbin/nginx ]];then
	clear
	$setcolor_success
	echo -n "Install nginx successfully"
	$setcolor
fi
