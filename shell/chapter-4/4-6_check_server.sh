#!/bin/bash

date_time=$(date +'%Y-%m-%d %H:%M:%S%z')

function check_server(){
	for i in "$@"
	do
		if systemctl --quiet is-active ${i}.service; then
			echo -e "[$date_time]: \e[92mservice $i is active \e[0m"
		else
			echo "[$date_time]: service $i is not active" >&2
		fi
	done
}

check_server httpd sshd vsftpd
