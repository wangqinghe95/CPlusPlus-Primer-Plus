#!/bin/bash

if [[ -z "$1" || -z "$2" || -z "$3" ]];then
	echo "Usage: $0 prescribed_path old_extension new_extension"
	exit
fi

for i in `ls $1/*.$2`
do
	mv $i ${i%.$2}.$3
done
