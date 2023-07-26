#!/bin/bash

trap 'kill $!' INT

bar(){
    while :
    do
        echo -ne '\e[42m \e[0m'
        sleep 0.3
    done
}

bar &
cp -r $1 $2
kill $!
echo "Copy end"