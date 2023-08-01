#!/bin/bash

echo "name[@]:"

name=(Jacob Rose Rick Vicky)
for i in "${name[@]}"
do
	echo "$i"
done


echo "name[*]:"
for i in "${!name[@]}" # get all indexes of the array
do
	echo ${name[i]}
done

echo "${!name[@]}"
