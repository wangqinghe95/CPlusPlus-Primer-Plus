#!/bin/bash

TCP_Total=$(ss -s | awk '$1=="TCP"{print $2}')
UDP_Total=$(ss -s | awk '$1=="UDP"{print $2}')

Unix_sockets_Total=$(ss -ax | awk 'BEGIN{count=0} {count++} END{print count}')

TCP_Listen_Total=$(ss -antlp | tail -n +2 | awk 'BEGIN{count=0} {count++} END{print count}')

TCP_Estab_Total=$(ss -antp | tail -n +2 | awk 'BEGIN{count=0} /^ESTAB/{count++} END{print count}')

TCP_SYN_RECV_Total=$(ss -antp |tail -n +2 | awk 'BEGIN{count=0} /^SYN-RECV/{count++} END{print count}')

TCP_TIME_WAIT_Total=$(ss -antp | tail -n +2 | awk 'BEGIN{count=0} /^TIME-WAIT/{count++} END{print count}')

TCP_TIME_WAIT1_Total=$(ss -antp |tail -n +2 | awk 'BEGIN{count=0} /^TIME-WAIT1/{count++} END{print count}')
TCP_TIME_WAIT2_Total=$(ss -antp |tail -n +2 | awk 'BEGIN{count=0} /^TIME-WAIT2/{count++} END{print count}')

TCP_Remote_Count=$(ss -antp | tail -n +2 | awk '$1!~/LISTEN/{IP[$5]++} END{ for (i in IP){print IP[i],i}}' | sort -nr)
TCP_Port_Count=$(ss -antp | tail -n +2 | sed -r 's/ +/ /g' | awk -F "[ :]" '$1!~/LISTEN/{port[$5]++} END{ for (i in port){print IP[i],i}}' | sort -nr)


SUCCESS="echo -en \\033[1;32m"
NORMAL="echo -en \\033[0;39m"

tcp_total(){
	echo -n "The Total of TPC connected: "
	$SUCCESS
	echo "$TCP_Total"
	$NORMAL
}

tcp_listen(){
	echo -n "The count of TCP port whose status is in Listen: "
	$SUCCESS
	echo "$TCP_Listen_Total"
	$NORMAL
}

tcp_estab(){
	echo -n "The count of TCP port whose status is in Estab: "
	$SUCCESS
	echo "$TCP_Estab_Total"
	$NORMAL
}

tcp_syn_recv(){
	echo -n "The count of TCP whose status is in SYNC-RECV: "
	$SUCCESS
	echo "$TCP_SYN_RECV_Total"
	$NORMAL
}

tcp_time_wait(){
	echo -n "The count of TCP whose status is in TIME-WAIT: "
	$SUCCESS
	echo "$TCP_TIME_WAIT_Total"
	$NORMAL
}

tcp_time_wait1(){
	echo -n "The count of TCP whose status is in TIME-WAIT1: "
	$SUCCESS
	echo "$TCP_TIME_WAIT1_Total"
	$NORMAL
}

tcp_time_wait2(){
	echo -n "The count of TCP whose status is in TIME-WAIT2: "
	$SUCCESS
	echo "$TCP_TIME_WAIT2_Total"
	$NORMAL
}

udp_total(){
	echo -n "The total of connected UDP: "
	$SUCCESS
	echo "$UDP_Total"
	$NORMAL
}

unix_total(){
	echo -n "The total of connected Unix sockets: "
	$SUCCESS
	echo "$Unix_sockets_Total"
	$NORMAL
}


remote_count(){
	echo "The connected number between local and remote: "
	$SUCCESS
	echo "$TCP_Remote_Count"
	$NORMAL
}

port_count(){
	echo "The number of every ports: "
	$SUCCESS
	echo "$TCP_Port_Count"
	$NORMAL
}

print_info(){
	echo -e "------------------------------------------------"
	$1
}


print_info tcp_total
print_info tcp_listen

print_info tcp_estab
print_info tcp_syn_recv
print_info tcp_time_wait
print_info tcp_time_wait1
print_info tcp_time_wait2

print_info udp_total
print_info unix_total
print_info  remote_count
print_info port_count

echo -e "------------------------------------------------"


