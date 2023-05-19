#!/bin/bash

demo1(){
	uname -r
}

demo2(){
	echo "start demo2"
	return 100
	echo "demo2 end"
}


demo3(){
	echo "demo3 hello"
	exit
}

demo1
echo "demo1 status: $?"

demo2
echo "demo2 status: $?"

demo3
echo "demo3 status: $?"
