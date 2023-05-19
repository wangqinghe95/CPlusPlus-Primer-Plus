#!/bin/bash

global_var1="hello"
global_var2="world"

function demo(){
	echo -e "\e[46mfunction [demo] started...\e[0m"
	func_var="Topic:"
	global_var2="Broke Girls"
	echo "$func_var $global_var2"
	echo -e "\e[46mfunction [demo] end.\e[0m"
}

demo
echo
echo "$func_var $global_var1 $global_var2"
