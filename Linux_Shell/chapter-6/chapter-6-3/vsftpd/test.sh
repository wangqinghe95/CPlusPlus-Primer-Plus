#!/bin/bash
conf_file=/etc/vsftpd.conf

# 查看指定文件是否存在指定关键字
result=$(grep 'chroot_local_user' $conf_file)
if [ -z "$result" ]; then
    echo 'grep is empty'
else
    echo 'grep is not empty'
fi

# 查看指定软件是否安装
if ! which vsftpd &> /dev/null ;then
    echo "Don't install vsftpd package"
    exit
fi

#查看指定软件是否启动
vsftpd_path=$(which vsftpd)
vsfptd_process=$(ps -ef | grep "vsftpd")
result=$(echo $vsfptd_process | grep "${vsftpd_path}")
if [[ "$result" != "" ]]; then
    echo "find"
else
    echo "No find"
fi

#字符串匹配（某个字符串中是否包含指定关键字）
# 方法1
str1=$(which vsftpd)
str2=$(ps -ef | grep "vsftpd")
if [[ $str2 =~ $str1 ]];then
    echo "Find"
else
    echo "Not Find"
fi

#方法2
exptr_result=$(expr index "$str1" "$str2")
if [[ $exptr_result -ne 0 ]];then
    echo "Find"
else
    echo "Not find"
fi

#方法3
result=$(echo $vsfptd_process | grep "${vsftpd_path}")
if [[ "$result" != "" ]]; then
    echo "find"
else
    echo "No find"
fi

# 获取服务状态
# get_service_status=$(service vsftpd status)
# if $(echo $get_service_status | grep "running") ;then
#     vsftpd_status="running"
# elif [[ $(echo $get_service_status | grep "dead") ]] ;then
#     vsftpd_status="dead"
# else
#     vsftpd="error"
# fi
# echo $vsftpd_status

# 获取函数中的结果值
get_str()
{
    echo "running"
}

echo $(get_str)

get_service_status(){
	get_service_status=$(service vsftpd status)
	if [[ $(echo $get_service_status | grep "running") ]];then
		vsftpd_status="running"
	elif [[ $(echo $get_service_status | grep "dead") ]] ;then
		vsftpd_status="dead"
	else
		vsftpd="error"
	fi
	echo $vsftpd_status
}

echo $(get_service_status)