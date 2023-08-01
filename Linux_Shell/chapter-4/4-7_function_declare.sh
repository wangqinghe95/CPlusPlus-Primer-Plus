#!/bin/bash

a=(aa bb cc)
declare -A b
b[a]=11
b[b]=22

function demo() {
	a=(xx yy zz)
	declare -A b
	b[a]=88
	b[b]=99
	echo ${a[@]}
	echo ${b[@]}
}

demo
echo ${a[@]}
echo ${b[@]}
