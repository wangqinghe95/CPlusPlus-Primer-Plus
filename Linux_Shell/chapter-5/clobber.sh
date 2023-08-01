#!/bin/bash

trap 'rm -rf /tmp/lockfile;exit' HUP INT

lock_check(){
	if (set -C; :> /tmp/lockfile) 2>/dev/null; then
		backup
	else
		echo -e "\e[91mWarnning: other user are using the scirpt.\e[0m"
		exit 66
	fi
}

backup(){
	touch /tmp/lockfile
	mysqldump --all-database > /var/log/mysql-$(date +%Y%m%d).bak
	sleep 10
	rm -rf /tmp/lockfile
}

lock_check
backup
