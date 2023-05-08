#!/bin/bash

RED_COL='\033[91m'
BLUE_COL='\033[34m'
NON_COL='\033[0m'
red_ball=""

while :
do
	echo "--Selected by computer double color--"
	tmp=$[RANDOM%33+1]
	echo "$red_ball" | grep -q -w $tmp && continue
	red_ball+=" $tmp"
	echo -en "$RED_COL$red_ball$NON_COL"
	word=$(echo "$red_ball" | wc -w)
	if [ $word -eq 6 ];then
		blue_ball=$[RANDOM%16+1]
		echo -e "$BLUE_COL $blue_ball$NON_COL"
		break
	fi
	sleep 0.5
done
