#!/bin/bash
read -p "please input a integer number" num
sum=$[num*(num+1)/2]
echo -e "\e[32m under $num integer number's sum:$sum\e[0m"
read -p "please input the length of angle:" bottom
read -p "please input the height of angle:" height
Area=$(echo "scale=1;1/2*$bottom*$height" | bc)
echo -e "\e[32mthe areas of the angle:$Area\e[0m"

read -p "please input the top length of trapezoid:" a
read -p "please input the bottom length of trapezoid:" b
read -p "please input the height of trapezoid:" h
Area=$(echo "scale=2;($a+$b)*$h/2" | bc)
echo -e "\e[32mThe areas of the trapezoid:$Area\e[0m"

read -p "please input a seconds:" sec
ms=$[sec*1000]
echo -e "\e[32m$sec seconds=$ms millisecond\e[0m"
us=$[sec*1000000]
echo -e "\e[32m$sec seconds=$us microsecond\e[0m"
hour=$(echo "scale=2;$sec/60/60"|bc)
echo -e "\e[32m$sec seconds=$hour hour\e[0m"
