#!/bin/bash

i=1
until [ $i -ge 5 ]
do
	echo $i
	let i++
done
