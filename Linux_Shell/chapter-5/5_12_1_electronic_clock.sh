#!/bin/bash

trap 'tput cnorm;exit' INT

number=(
'  0000000000      111     2222222222  3333333333  44    44    5555555555  6666666666  7777777777  8888888888  9999999999  '
'  00      00    11111             22          33  44    44    55          66          77      77  88      88  99      99  '
'  00      00   111111             22          33  44    44    55          66          77      77  88      88  99      99  '
'  00      00       11             22          33  44    44    55          66                  77  88      88  99      99  '
'  00      00       11     2222222222  3333333333  4444444444  5555555555  6666666666          77  8888888888  9999999999  '
'  00      00       11     22                  33        44            55  66      66          77  88      88          99  '
'  00      00       11     22                  33        44            55  66      66          77  88      88          99  '
'  00      00       11     22                  33        44            55  66      66          77  88      88          99  '
'  0000000000  1111111111  2222222222  3333333333        44    5555555555  6666666666          77  8888888888  9999999999  '
)

now_time(){
    hour=$(date +%H)
    min=$(date +%M)
    sec=$(date +%S)

    # echo "hour $hour min $min sec $sec"

    hour_left=`echo $hour/10 | bc`
    hour_right=`echo $hour%10 | bc`
    min_left=`echo $min/10 | bc`
    min_right=`echo $min%10 | bc`
    sec_left=`echo $sec/10 | bc`
    sec_right=`echo $sec%10 | bc`

    # echo "hour_left $hour_left hour_right $hour_right"
    # echo "min_left $min_left min_right $min_right"
    # echo "sec_left $sec_left sec_right $sec_right"

}

print_time(){
    # echo " print_time $1 $2"
    begin=$[$1*12]
    # echo "begin $begin"
    # echo `seq 0 ${#number[@]}`
    for i in `seq 0 ${#number[@]}`
    do
        tput cup $[i+5] $2
        echo -en "\033[32m${number[i]:$begin:12}\033[0m"
    done
}

print_punct(){
    tput cup $1 $2
    echo -en "\e[32m\u2588\e[0m"
}

while :
do 
    tput civis
    now_time
    print_time $hour_left 2
    print_time $hour_right 14
    print_punct 8 28
    print_punct 10 28
    print_time $min_left 30
    print_time $min_right 42
    print_punct 8 56
    print_punct 10 56
    print_time $sec_left 58
    print_time $sec_right 70
    sleep 1
    echo

done