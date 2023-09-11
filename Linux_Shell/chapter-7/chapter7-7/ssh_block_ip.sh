#!/bin/bash

trap 'kill $one_pid; kill $five_pid; kill $fifteen_pid; exit' EXIT INT

LOGFILE=auth.log
BLOCKFILE=blockip.txt

one_minute(){
	while :
	do
		local curtime_month=$(LANG=C date +"%b")
		local curtime_day=$(LANG=C date +"%e")
		local curtime_time=$(LANG=C date +"%T")
		local one_minus_ago=$(LANG=C date -d "1 minutes ago" +"%T")
		local curtime_seconds=$(LANG=C date +"%s")	

		pass_fail_ip=$(awk '
					$1=="'$curtime_month'" && \
					$2=='"$curtime_day"' && \
					$3>="'$one_minus_ago'" && \
					$3<="'$curtime_time'"	\
					{  if($6=="Failed" && $9!="invalid") {print $(NF-3)}}' $LOGFILE | \
					awk '{IP[$1]++} END{for(i in IP){ if(IP[i]>=3){print i}}}')


		for i in $pass_fail_ip
		do
			if ! grep -q "$i" $BLOCKFILE; then
				echo "$curtime_seconds $i" >> $BLOCKFILE
			fi
		done

		user_invalid_ip=$(awk '
					$1=="'$curtime_month'" && \
					$2=='"$curtime_day"' && \
					$3>="'$one_minus_ago'" && \
					$3<="'$curtime_time'"	\
					{if($6=="Invalid") {print $(NF-2)}}' $LOGFILE | \
					awk '{IP[$1]++} END{for(i in IP){if(IP[i]>=3){print i}}}')
		for j in $user_invalid_ip
		do
			if ! grep -q "$j" $BLOCKFILE ;then
				echo "$curtime_seconds $j" >> $BLOCKFILE
			fi
		done

		sleep 60
	done
}

five_minutes(){
	while :
	do
		local curtime_month=$(LANG=C date +"%b")
		local curtime_day=$(LANG=C date +"%e")
		local curtime_time=$(LANG=C date +"%T")
		local one_minus_ago=$(LANG=C date -d "5 minutes ago" +"%T")
		local curtime_seconds=$(LANG=C date +"%s")	

		pass_fail_ip=$(awk '
					$1=="'$curtime_month'" && \
					$2=='"$curtime_day"' && \
					$3>="'$one_minus_ago'" && \
					$3<="'$curtime_time'"	\
					{  if($6=="Failed" && $9!="invalid") {print $(NF-3)}}' $LOGFILE | \
					awk '{IP[$1]++} END{for(i in IP){ if(IP[i]>=3){print i}}}')

		# pass_fail_ip=$(awk '
		# 	$1=="'$curtime_month'" && \
		# 	$2=='"$curtime_day"' && \
		# 	$3>="'$one_minus_ago'" && \
		# 	$3<="'$curtime_time'" \
		# 	{ if($6=="Failed" && $9!="invalid") {print $(NF-3)}}'
		# 	$LOGFILE | \
		# 	awk '{IP[$1]++} END{ for(i in IP){ if(IP[i]>=3) {print
		# 	i} } }')
		for i in $pass_fail_ip
		do
			if ! grep -q "$i" $BLOCKFILE; then
				echo "$curtime_seconds $i" >> $BLOCKFILE
			fi
		done

		user_invalid_ip=$(awk '
					$1=="'$curtime_month'" && \
					$2=='"$curtime_day"' && \
					$3>="'$one_minus_ago'" && \
					$3<="'$curtime_time'"	\
					{if($6=="Invalid") {print $(NF-2)}}' $LOGFILE | \
					awk '{IP[$1]++} END{for(i in IP){if(IP[i]>=3){print i}}}')
		for j in $user_invalid_ip
		do
			if ! grep -q "$j" $BLOCKFILE ;then
				echo "$curtime_seconds $j" >> $BLOCKFILE
			fi
		done

		sleep 60
	done	
}

fifteen_minutes(){
	while :
	do
		local curtime_month=$(LANG=C date +"%b")
		local curtime_day=$(LANG=C date +"%e")
		local curtime_time=$(LANG=C date +"%T")
		# local one_minus_ago=$(LANG=C date -d "15 minutes age" +"%T")
		local one_minus_ago=$(LANG=C date -d "15 minutes ago" +"%T")
		local curtime_seconds=$(LANG=C date +"%s")	

		pass_fail_ip=$(awk '
					$1=="'$curtime_month'" && \
					$2=='"$curtime_day"' && \
					$3>="'$one_minus_ago'" && \
					$3<="'$curtime_time'"	\
					{  if($6=="Failed" && $9!="invalid") {print $(NF-3)}}' $LOGFILE | \
					awk '{IP[$1]++} END{for(i in IP){ if(IP[i]>=3){print i}}}')


		for i in $pass_fail_ip
		do
			if ! grep -q "$i" $BLOCKFILE; then
				echo "$curtime_seconds $i" >> $BLOCKFILE
			fi
		done

		user_invalid_ip=$(awk '
					$1=="'$curtime_month'" && \
					$2=='"$curtime_day"' && \
					$3>="'$one_minus_ago'" && \
					$3<="'$curtime_time'"	\
					{if($6=="Invalid") {print $(NF-2)}}' $LOGFILE | \
					awk '{IP[$1]++} END{for(i in IP){if(IP[i]>=3){print i}}}')
		for j in $user_invalid_ip
		do
			if ! grep -q "$j" $BLOCKFILE ;then
				echo "$curtime_seconds $j" >> $BLOCKFILE
			fi
		done

		sleep 60
	done
}

clear_block_ip(){
	while :
	do
		sleep 1200
		local curtime_seconds=$(LANG=C date +"%s")
		tmp=$(awk -v now=$curtime_seconds '(now-$1)>=1200 {print $2}' $BLOCKFILE )
		for i in $tmp
		do
			sed -i "/$i/d" $BLOCKFILE
		done
	done
}

> $BLOCKFILE
one_minute &
one_pid="$!"

five_minutes &
five_pid="$!"

fifteen_minutes &
fifteen_pid="$!"
clear_block_ip
