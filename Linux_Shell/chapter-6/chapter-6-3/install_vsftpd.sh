#!/bin/bash

SUCCESS="echo -en \\033[1;32m"	#green
FAILURE="echo -en \\033[1;32m" #red
WARNING="echo -en \\033[1;33m"	#yellow
NORMAL="echo -en \\033[1;39m"	#black
conf_file=/etc/vsftpd.conf

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
	echo "#   3. Restart vsftpd.                     #"
	echo "--------------------------------------------"
	echo	
}


check_vsftpd_package(){
	check_result=$(apt-cache search vsftp | awk  'NR==1 {print $1}')
    if [[ "vsftpd" == $check_result ]];then
        $SUCCESS
        echo "The package of vsftpd has existed, and can install"
        $NORMAL
    else
        $WARNING
        echo "There is no vsftpd package, please apt update"
        $NORMAL
    fi
}

install_vsftpd(){
    package_status=$(dpkg -l | grep vsftpd | awk '{print $1}')
    # if [ $package_status == "ii" -o $package_status == "iU" ]; then
    if [[ $package_status == "ii" || $package_status == "iU" ]]; then
        $NORMAL
        echo "The package of vsftpd has been installed"
        $NORMAL
        vsftpd -v
    else
        sudo apt-get install vsftpd &> /dev/null
        wait $!
        if [ $? -eq 0 ];then
            $SUCCESS
            echo "The package of vsftpd has installed sucessfully"
            vsftpd -v
            $NORMAL
        else
            $FAILURE
            echo "The package of vsftpd has installed failed"
            $NORMAL
        fi
    fi
}

init_config(){
    [ ! -e  $conf_file.bak ] && sudo cp $conf_file{,.bak}
    [ ! -d /common/pub ] && sudo mkdir -p /common/pub
    sudo chmod a+x /common/pub
    sudo sed -i 's/^#chroot_local_user=YES/chroot_local_user=YES/' $conf_file
    result=$(grep 'chroot_local_user=YES' $conf_file)
    if [ -z "$result" ]; then
        $FAILURE
        echo 'Can not find chroot_local_user=YES'
        $NORMAL
    else
        $SUCCESS
        echo 'Modify chroot_local_user=YES successfully'
        $NORMAL
    fi
}

create_ftpuser(){
	if id $1 &> /dev/null ;then
		$FAILURE
		echo "$1 Account has existed"
		$NORMAL
		exit
	else
		sudo useradd $1
		echo "$2" | sudo chpasswd $1 &> /dev/null
	fi
}

delete_ftpuser(){
	if ! id $1 &> /dev/null ;then
		$FAILURE
		echo "$1 Account not exist"
		$NORMAL
		exit
	else
		sudo userdel $1
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
		sudo sed -i 's/anonymous_enable=YES/anonymous_enable=NO/' $conf_file
		sudo systemctl restart vsftpd;;
	2)
		sudo sed -i 's/anonymous_enable=NO/anonymous_enable=YES/' $conf_file
		sudo systemctl restart vsftpd;;
	3)
		sudo sed -i 's/^#anon_/anon_/' $conf_file
        folder_path=/var/ftp/pub
        if [ ! -e $folder_path ]; then
            sudo mkdir -p $folder_path
        fi
		sudo chmod a+w /var/ftp/pub
		sudo systemctl restart vsftpd;;
	esac
}

get_service_status(){
	get_service_status=$(service vsftpd status)
	if [[ $(echo $get_service_status | grep "running") ]] ;then
		vsftpd_status="running"
	elif [[ $(echo $get_service_status | grep "dead") ]] ;then
		vsftpd_status="dead"
	else
		vsftpd="error"
	fi
	echo $vsftpd_status
}

proc_manager(){
	if ! which vsftpd &> /dev/null ;then
		$FAILURE
		echo "Don't install vsftpd package"
		$NORMAL
		exit
	fi

	case $1 in
	start)
		sudo systemctl start vsftpd
		if [[ $(get_service_status) == "running" ]];then
			echo "Start vsftpd successfully"
		else
			echo "Start vsftpd failed"
		fi
		;;
	stop)
		sudo systemctl stop vsftpd
		if [[ $(get_service_status) == "dead" ]];then
			echo "Close vsftpd successfully"
		else
			echo "Close vsftpd failed"
		fi
		;;
	restart)
		sudo systemctl restart vsftpd
		if [[ $(get_service_status) == "running" && $? == 0 ]];then
			echo "Reastart vsftpd successfully"
		else
			echo "Reastart vsftpd failed"
		fi
		;;
	esac


}

menu
read -p "Please input option[1-6]:" input
case $input in
1)
	check_vsftpd_package
	install_vsftpd
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
