#!/bin/bash

SUCCESS="echo -en \\033[1;32m"	#green
FAILURE="echo -en \\033[1;32m" #red
WARNING="echo -en \\033[1;33m"	#yellow
NORMAL="echo -en \\033[1;39m"	#black
conf_file=/etc/vsftpd/vsftpd.conf

menu(){
	clear
	echo "---------------------------------------"
	echo "#            Menu                     #"
	echo "---------------------------------------"
	echo "#      1. Install vsftpd              #"
	echo "#      2. Create FTP's count          #"
	echo "#      3. Delete FTP's count          #"
	echo "#      4. Config anonymous count      #"
	echo "#      5. Start or close vsftpd       #"
	echo "#      6. Exit script                 #"
	echo "---------------------------------------"
	echo
}

anon_sub_menu(){
	clear
	echo "--------------------------------------------"
	echo "#      Configure Anonymous Sub Menu        #"
	echo "--------------------------------------------"
	echo "#   1. Disable Anonymous Account.          #"
	echo "#   2. Enable Anonymous Account.           #"
	echo "#   3. Allow Anonymous Account to upload.   "
	echo "--------------------------------------------"
	echo
}

service_sub_menu(){
	clear
	echo "--------------------------------------------"
	echo "#         Service Manage Sub Menu          #"
	echo "--------------------------------------------"
	echo "#   1. Start vsftpd.                       #"
	echo "#   2. Close vsftpd.                       #"
	echo "#   1. Restart vsftpd.                     #"
	echo "--------------------------------------------"
	echo	
}

test_yum(){
	num=$(yum repolist | tail -1 | sed 's/.*: *//;s/,//')
	if [ $num -le 0 ];then
		$FAILURE
		echo "There are none Yum's source can be used"
		$NORMAL
		exit
	else
		if ! yum list vsftpd &> /dev/null ;then
			$FAILURE
			echo "There are no package of vsftpd in YUM"
			$NORMAL
			exit
		fi
	fi
}

install_vsftpd(){
	if rpm -q vsftpd &> /dev/null ;then
		$WARNING
		echo "Vsftpd had installed"
		$NORMAL
		exit
	else
		yum -y install vsftpd
	fi
}

init_config(){
	[ ! -e $config_file.bak ] && cp $conf_file{,.bak}

	[ ! -d /common/pub ] && mkdir -p /common/pub
	chmod a+w /common/pub
	grep -q local_root $conf_file || sed -i '$a local_root=/common' $conf_file

	sed -i 's/^#chroot_local_user=YES/chroot_local_user=YES/' $conf_file
}

create_ftpuser(){
	if id $1 &> /dev/null ;then
		$FAILURE
		echo "$1 Account has existed"
		$NORMAL
		exit
	else
		useradd $1
		echo "$2" | chpasswd $1 &> /dev/null
	fi
}

delete_ftpUser(){
	if ! id $1 &> /dev/null ;then
		$FAILURE
		echo "$1 Account not exist"
		$NORMAL
		exit
	else
		userdel $1
	fi
}

anon_config(){
	if [ ! -f $conf_file ];then
		$FAILURE
		echo "The config file is not exist"
		$NORMAL
		exit
	fi

	case $1 in
	1)
		sed -i 's/anonymous_enable=YES/anonymous_enable=NO/' $conf_file
		systemctl restart vsftpd;;
	2)
		sed -i 's/anonymous_enable=NO/anonymous_enable=YES/' $conf_file
		systemctl restart vsftpd;;
	3)
		sed -i 's/^#anon_/anon_/' $conf_file
		chmod a+w /var/ftp/pub
		systemctl restart vsftpd;;
	esac
}

proc_manager(){
	if ! rpm -q vsftpd &> /dev/null ;then
		$FAILURE
		echo "Don't install vsftpd package"
		$NORMAL
		exit
	fi

	case $1 in
	start)
		systemctl start vsftpd;;
	stop)
		systemctl stop vsftpd;;
	restart)
		systemctl restart vsftpd;;
	esac
}

menu
read -p "Please input option[1-6]:" input
case $input in
1)
	test_yum
	isntall_vsftpd
	init_config;;
2)
	read -p "Please input Account:" username
	read -p "Please input passwd:" password
	echo
	create_ftpuser $username $password;;
3)
	read -p "Please input Account:" username
	delete_ftpuser $username $password;;
4)
	anon_sub_menu
	read -p "Please input option[1-3]:" anon
	if [ $anon -eq 1 ];then
		anon_config 1
	elif [ $anon -eq 2 ];then
		anon_config 2
	elif [ $anon -eq 3 ];then
		anon_config 3
	fi;;
5)
	service_sub_menu
	read -p "Please input option[1-3]:" proc
	if [ $proc -eq 1 ];then
		proc_manager start
	elif [ $proc -eq 2 ];then
		proc_manager stop
	elif [ $proc -eq 3 ];then
		proc_manager restart
	fi;;
6)
	exit;;
*)
	$FAILURE
	echo "Input Failure"
	$NORMAL
	exit;;
esac

