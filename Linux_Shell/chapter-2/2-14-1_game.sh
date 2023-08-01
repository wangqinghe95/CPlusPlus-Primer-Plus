#!/bin/bash

computer=$[RANDOM%3+1]

clear
echo "##############################"
echo "#The rock-paper-scissors game#"

echo -e "#\e[032m please throw a morra:\e[0m"
echo "##############################"
echo "|----------------------------|"
echo "| 1. rock                    |"
echo "| 2. paper                   |"
echo "| 3. scissor                 |"
echo "|----------------------------|"

read -p "please input a number which range 1~3: " person

case $person in
1)
	echo "_________________________"
	echo "| Person Morra: Rock    |"
	if [[ "$computer" == 1 ]];then
		echo "| Computer Morra: Rock  |"
		echo "_________________________"
		echo -e "\e[32m Draw. \e[0m" 
	elif [[ "$computer" == 2 ]];then
		echo "| Computer Morra: Scissor|"
		echo "_________________________"
		echo -e "\e[32m Congratulations! You won. \e[0m" 
	elif [[ "$computer" == 3 ]];then
		echo "| Computer Morra: Paper|"
		echo "_________________________"
		echo -e "\e[32m Computer won. \e[0m" 
	fi;;
3)
	echo "_________________________"
	echo "| Person Morra: Paper    |"
	if [[ "$computer" == 1 ]];then
		echo "| Computer Morra: Rock  |"
		echo "_________________________"
		echo -e "\e[32m Congratulations! You won.\e[0m" 
	elif [[ "$computer" == 2 ]];then
		echo "| Computer Morra: Scissor|"
		echo "_________________________"
		echo -e "\e[32m Computer won. \e[0m" 
	elif [[ "$computer" == 3 ]];then
		echo "| Computer Morra: Paper|"
		echo "_________________________"
		echo -e "\e[32m Draw. \e[0m" 
	fi;;
2)
	echo "_________________________"
	echo "| Person Morra: Scissor    |"
	if [[ "$computer" == 1 ]];then
		echo "| Computer Morra: Rock  |"
		echo "_________________________"
		echo -e "\e[32m Computer won.\e[0m" 
	elif [[ "$computer" == 2 ]];then
		echo "| Computer Morra: Scissor|"
		echo "_________________________"
		echo -e "\e[32m Draw. \e[0m" 
	elif [[ "$computer" == 3 ]];then
		echo "| Computer Morra: Paper|"
		echo "_________________________"
		echo -e "\e[32m Congratulations. You won. \e[0m" 
	fi;;
*)
	echo -e "\e[91m Invalid input, please input a value within 1~3:\e[0m";;
esac


