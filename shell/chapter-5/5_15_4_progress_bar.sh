#!/bin/bash

trap 'kill $!' INT

rotate='|/-\'

bar(){
    printf ' '
    while :
    do
        printf "\b%.1s" "$rotate"
        rotate=${rotate#?}${rotate%???}
        sleep 0.2
    done
}

bar &
cp -r $1 $2
kill $!
echo -e "\n"
echo "Copy end"