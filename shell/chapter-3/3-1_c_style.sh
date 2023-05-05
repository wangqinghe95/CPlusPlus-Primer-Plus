#!/bin/bash

for ((i=1;i<=5;++i))
do
	echo $i
done


for ((i=1,j=5;i<=5;i++,j--))
do
	echo "$i $j"
done
