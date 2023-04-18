#!/bin/bash

# the scripts obtains the performance paramters of the system
# And decide whether to send a message to the administrator for alert to the preset threshold

# get from time
local_time=$(date +"%Y%m%d %H:%M:%S")
echo "time:$local_time"

local_ip=$(ifconfig enp0s3 | grep Mask | tr -s " " | cut -d " " -f3)
echo "ip:$local_ip"

free_mem=$(cat /proc/meminfo | grep Avai | tr -s " " | cut -d " " -f2)
echo "free mem:$free_mem"

free_disk=$(df | grep "/$" | tr -s " " | cut -d " " -f4)
echo "free disk : $free_disk"

cpu_load=$(cat /proc/loadavg | cut -d " " -f3)
echo "cpu : $cpu_load"

login_user=$(who | wc -l)
echo "login : $login_user"

procs_num=$(ps aux | wc -l)
echo "process num : $procs_num"

irq=$(vmstat 1 2 | tail -n +4 | tr -s ' ' | cut -d ' ' -f12)
echo "irq = $irq"
cs=$(vmstat 1 2 | tail -n +4 | tr -s ' ' | cut -d ' ' -f13)
echo "cs = $cs"

usertime=$(vmstat 1 2 | tail -n +4 | tr -s ' ' | cut -d ' ' -f14)
echo "usertime = $usertime"
systime=$(vmstat 1 2 | tail -n +4 | tr -s ' ' | cut -d ' ' -f15)
echo "systime = $systime"
iowait=$(vmstat 1 2 | tail -n +4 | tr -s ' ' | cut -d ' ' -f17)
echo "iowait = $iowait"

[ $free_mem -gt 1048576 ] && \
echo "$local_time Free memory not enough.
Free_mem : $free_mem on $local_ip" | \
mail -s "Waning" luis.wang@aptiv.com
