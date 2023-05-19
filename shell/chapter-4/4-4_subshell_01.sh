#!/bin/bash

tmp_file="./tmp.txt"

df | grep "^/" > $tmp_file

while read name total used free other
do
	let sum+=free
done < $tmp_file
rm -rf $tmp_file
echo $sum
