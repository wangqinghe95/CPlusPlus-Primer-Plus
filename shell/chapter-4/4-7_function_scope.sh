#!/bin/bash
global_var1="global_var1"
global_var2="global_var2"

function demo() {
	local_var="local_var"
	global_var2="local_var2"
	echo "global_var:$global_var1 $global_var2"
}

echo "function var:[$local_var]"
echo "$global_var1 $global_var2"
