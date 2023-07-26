#!/bin/bash

trap 'kill $!' INT

bar(){
    while :
    do
        pound=""
        for ((i=47;i>=1;i--))
        do
            pound+=#
            printf "|%s%${i}s|\r" "$pound"
            sleep 0.2
        done
    done
}

bar &
cp -r $1 $2
kill $!
echo -e "\n"
echo "Copy end"