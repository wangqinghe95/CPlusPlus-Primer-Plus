#!/bin/bash

kernel=$(uname -r)
release=$(cat /etc/issue)
hostname=$HOSTNAME
local_IP=$(ip a s | awk '/inet /{print $2}')
mem_total=$(free | awk '/Mem/{print $2}')
mem_free=$(free | awk '/Mem/{print $2}')
swap_total=$(free | awk '/Swap/{print $2}')
swap_free=$(free | awk '/Swap/{print $NF}')
disk=$(df | awk '/^\/dev/{print $1,$2,$4}'|column -t)
cpu_load_1_minte=$(uptime | sed 's/,//g' | awk '{print $(NF-2)}')
cpu_load_5_mintes=$(uptime | sed 's/,//g' | awk '{print $(NF-1)}')
cpu_load_15_mintes=$(uptime | sed 's/,//g' | awk '{print $(NF)}')
login_users=$(who | wc -l)
procs=$(ps aux | wc -l)
users=$(sed -n '$=' /etc/passwd)
cpu_info=$(LANG=C lscpu | awk -F: '/Model name/ {print $2}')
cpu_core=$(awk '/processor/{core++} END{print core}' /proc/cpuinfo)

echo -e "\033[34mExtracting the disk performance indicators. please wait ... "
tps=$(LANG=C sar -d -p 1 6 | awk '/Average/' | \
    tail -n +2 | awk '{print "["$2"]The Average Number of disk for IO:"$3}') &
read_write=$(LANG=C sar -d -p 1 6 |awk '/Average/' | \
    tail -n +2 | awk '{print "["$2"]The Average amount of read-write sectors per second:"$4,$5}') &

irq=$(vmstat 1 2 | tail -n +4 | awk '{print $11}')
cs=$(vmstat 1 2 | tail -n +4 | awk '{print $12}')

top_proc_mem=$(ps --no-headers -eo comm,rss | sort -k2 -n | tail -10)
top_proc_cpu=$(ps --no-headers -eo comm,rss | sort -k2 -n | tail -5)

net_monitor=$(cat /proc/net/dev | tail -n +3 | \
            awk 'BEGIN{print "[Net Car dName] [Inbound data traffic] [Outbound data traffic]"} \
            {print $1,$2,$10}' | column -t)
        
echo -e "\033[32m---------------Table of Local Main Parameters----------------\033[\0m"
echo -e "List of Local IP Address:\033[32m$local_IP\033[0m"
echo -e "Native Host Name:\033[32m$hostname\033[0m"
echo -e "Operation System Version:\033[32m$release\033[0m,The Kernel Version:\033[32m$kernel\033[0m"
echo -e "CPU Model:\033[32m$cpu_info\033[0m,Number of CPU Cores:\033[32m$cpu_core\033[0m"
echo -e "Local Total Memory Capacity:\033[32m$mem_total\033[0m,The Remaining Available Memory Capacity:\033[32m$mem_free\033[0m"

echo -e "Total Capacity of The native Swap:\033[32m$swap_total\033[0m,The Remaining Capacity:\033[32m$swap_free\033[0m"

echo -e "The Average Loads of Recent 1min 5mins 15mins:\033[32m$cpu_load_1_minte $cpu_load_5_mintes $cpu_load_15_mintes\033[0m"

echo -e "Local Total counts:\033[32m$users\033[0m,Number of Accounts currently Logged:\033[32m$login_users\033[0m"
echo -e "Number of Runing Process Current System:\033[32m$procs\033[0m"
echo -e "List of Last 10 Processes Occupied CPU:"
echo -e "\033[32m$top_proc_cpu\033[0m"
echo -e "List of Last 10 Processes Occupied Memory:"
echo -e "\033[32m$top_proc_mem\033[0m"

echo -e "Number of CPU Interruptions:\033[32m$irq\033[0m,\
        Number of Switching Context:\033[32m$cs\033[0m,"

echo -e "The total and residual capacity information for each disk partition is as follows:"
echo -e "$disk"
echo -e "$tps"
echo -e "$read_write"
echo -e "$net_monitor"

echo -e "\033[32m--------------------------The End ---------------------------\033[\0m"