#!/bin/bash

trap 'kill $!' INT

src=$(du -s $1 | cut -f1)
dst=0

bar(){
    while :
    do
        size=$(echo "scale=2;$dst/$src*100" | bc)
        echo -en "\r|$size%|"
        [ -f $2 ] && dst=$(sudo du -s $2 | sudo cut -f1)
        [ -d $2 ] && dst=$(sudo du -s $2/$1 | sudo cut -f1)
        sleep 0.2
    done
}

bar &
cp -r $1 $2
kill $!
echo -e "\n"
echo "Copy end"