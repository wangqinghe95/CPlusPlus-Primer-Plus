#!/bin/bash

tmpfile="/tmp/procs_mem_$$.txt"

ps --no-headers -eo comm,rss > $tmpfile
bubble(){
	local i j
	local len=$1
	for ((i=1;i<=$[len-1];i++))
	do
		for ((j=1;j<=$[len-1];j++))
		do
			if [ ${mem[j]} -gt ${mem[j+1]} ];then
				tmp=${mem[j]}
				mem[$j]=${mem[j+1]}
				mem[j+1]=$tmp
				tmp=${mem[j]}
				name[$j]=${name[j+1]}
				name[j+1]=$tmp
			fi
		done
	done
	echo "Process seq after sort:"
	echo "---------------------------------------"
	echo "${name[@]}"
	echo "---------------------------------------"
	echo "${mem[@]}"
	echo "---------------------------------------"
}

i=1
while read proc_name proc_mem
do
	name[$i]=$proc_name
	mem[$i]=$proc_mem
	let i++
done < $tmpfile
rm -rf $tmpfile
bubble ${#mem[@]}
