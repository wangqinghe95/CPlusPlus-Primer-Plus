#!/bin/bash

GREEN_COL='\033[32m'
NONE_COL='\033[0m'

line='echo ++++++++++++++++++++++++++++++++++++++++++++++'
logfile="$1"

if [ ! -f $logfile ];then
	echo "$logfile is not existed"
	exit
fi

PV=$(sed -n '$=' $logfile)
UV=$(awk '{IP[$1]++} END{ print length(IP)}' $logfile)

Average_PV=$(echo "scale=2;$PV/$UV" | bc)
IP=$(awk '{IP[$1]++} END{for(i in IP){print i, "\tThe times for visiting:", IP[i]}"\r"}' $logfile | sort -rn -k3)

STATUS=$(awk '{IP[$9]++} END{for(i in IP){print i "\tThe times for stauts:", IP[i]}"\r"}' $logfile | sort -rn -k2)

Body_size=$(awk '{SUM+=$10} END{print SUM}' $logfile)

URI=$(awk '{IP[$7]++} END{for(i in IP){if(IP[i]>=3){print i"\tThe times for visiting:", IP[i]}}}' $logfile)


echo -e "\033[91m\tThe Database for Analyzing Log\033[0m"

$line
echo -e "The total of PV: $GREEN_COL$PV$NONE_COL"
echo -e "The total of UV: $GREEN_COL$UV$NONE_COL"
echo -e "The total of Average: $GREEN_COL$Average_PV$NONE_COL"

$line
echo -e "The Accumulation Byte: $GREEN_COL$Body_size$NONE_COL Byte"


$line
echo "$STATUS"

$line
echo "$IP"

echo -e "($GREEN_COL)The URI times more than 500:($NONE_COL)"
echo "$URI"
