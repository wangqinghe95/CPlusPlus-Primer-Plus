#!/bin/bash

trap 'kill $!' INT

bar(){
    while :
    do
        echo -n '#'
        sleep 0.3
    done
}

bar &
cp -r $1 $2
kill $!
echo "Copy end"