#!/bin/bash
clear
echo -e "\e[42m---------------------------------------\e[0m"
echo -e "\e[2;10H 这里是菜单\t\t#"
echo -e "\e[32m 1. 查看网卡信息\e[0m            #"
echo -e "\e[33m 2. 查看内存信息\e[0m            #"
echo -e "\e[34m 2. 查看磁盘信息\e[0m            #"
echo -e "\e[35m 2. 查看 CPU 信息\e[0m            #"
echo -e "\e[36m 2. 查看账户信息\e[0m            #"
echo -e "\e[42m---------------------------------------\e[0m"
echo

read -p "please input option [1~5]:" key
case $key in
1)
    ifconfig | head -2;;
2) 
    mem=$(free | grep Mem | tr -s " " | cut -d " " -f7)
    echo "The local Machine's rest Memory : ${mem}K";;
3)
    root_free=$(df | grep /$ | tr -s " " | cut -d " " -f4)
    echo "The local Machine's root rest Memory: ${root_free}K.";;
4)
    cpu=$(uptime | tr -s " " | cut -d " " -f11)
    echo "The local CPU's average load for 15mins : $cpu";;
5)
    log_num=$(who | wc -l)
    total_num=$(cat /etc/passwd | wc -l)
    echo "The current admin's User: $USER"
    echo "The num of logging accounts: $log_num"
    echo "The num of total accounts: $total_num";;
*)
    echo "input error,out of range of 1~5"
esac