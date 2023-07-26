#!/bin/bash

if [ $# -eq 0 ];then
    echo "Usage: $0 File Name..."
    exit 1
fi

while (($#))
do
    if [ ! -s $1 ];then
        echo -e "\e[31m $1 is empty, rm...\e[0m"
        rm -rf $1
    else
        [ -f $1 ] && echo -e "\e[32m$1 is non empty file.\e[0m"
        [ -d $1 ] && echo -e "\e[32m$1 is directory, not a file.\e[0m"
    fi
    shift
done