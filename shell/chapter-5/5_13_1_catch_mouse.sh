#!/bin/bash

trap 'proc_exit' EXIT INT

lines=`tput lines`
column=`tput cols`
left=2
right=$[column/2]
top=2
bottom=$[lines/2]

draw_map(){
    save_property=$(stty -g)
    tput clear
    tput civis
    echo -e "\e[1m\nw[up],s[down],a[left],d[right],q[exit],Control faces to catch the randomly presented mice"
    for y in `seq $top $bottom`
    do
        local x=$left
        if [[ $y -eq $top || $y -eq $bottom ]];then
            while [ $x -le $right ]
            do
                tput cup $y $x
                echo -ne "\033[37;42m#\033[0m"
                let x++
            done
        else
            for m in $left $right
            do
                tput cup $y $m
                echo -ne "\033[37;42m#\033[0m"
            done  
        fi
    done
    echo
}

clear_screen(){
    for((i=3;i<=$[bottom-1];i++))
    do
        space=""
        for((j=3;j<=$[right-1];j++))
        do
            space=${space}" "
        done
        tput cup $i 3
        echo -n "$space"
    done
}

draw_mouse(){
    tput cup $1 $2
    echo -en "\U1f42d"
}

draw_player(){
    tput cup $1 $2
    echo -en "\U1f642"
}

proc_exit(){
    tput cnorm
    stty $save_property
    clear_screen
    tput cup $[bottom/2] $[right/2-7]
    echo "GameOver."
    tput cup $[bottom/2+1] $[right/2-7]
    if [[ "success" = $1 ]];then
        echo "You've caught the mouse"
    elif [[ "quit" = $1 ]];then
        echo "You've quit game"
    else
        echo "You've hit the wall"
    fi
    tput cup $[bottom+2] 0

    exit
}

get_key(){
    man_x=4
    man_y=4
    tmp_col=$[right-2]
    tmp_line=$[bottom-1]
    rand_x=$[RANDOM%(tmp_col-left)+left+1]
    rand_y=$[RANDOM%(tmp_line-top)+top+1]
    while :
    do
        draw_player $man_y $man_x
        draw_mouse $rand_y $rand_x
        if [[ $man_x -eq $rand_x && $man_y -eq $rand_y ]];then
            clear_screen
            proc_exit "success"
        fi
        stty -echo
        read -s -n 1 input
        if [[ $input == "q" || $input == "Q" ]];then
            proc_exit "quit"
        elif [[ $input == "w" || $input == "W" ]];then
            let man_y--
            [[ $man_y -le $top || $man_y -ge $bottom ]] && proc_exit
            draw_player $man_y $man_x
        elif [[ $input == "s" || $input == "S" ]];then
            let man_y++
            [[ $man_y -le $top || $man_y -ge $bottom ]] && proc_exit
            draw_player $man_y $man_x
        elif [[ $input == "a" || $input == "A" ]];then
            let man_x--
            [[ $man_x -le $left || $man_x -ge $right ]] && proc_exit
            draw_player $man_y $man_x
        elif [[ $input == "d" || $input == "D" ]];then
            let man_x++
            [[ $man_x -le $left || $man_x -ge $right ]] && proc_exit
            draw_player $man_y $man_x
        fi
        clear_screen     
    done
}

draw_map
get_key