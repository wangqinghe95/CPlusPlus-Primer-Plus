#!/bin/bash

read -p "please input the score : " score
if [[ $score -gt 90 ]];then
	echo "笑傲江湖"
elif [[ $score -gt 80 ]];then
	echo "登峰造极"
elif [[ $score -gt 70 ]];then
	echo "炉火纯青"
elif [[ $score -gt 60 ]];then
	echo "略有小成"
elif [[ $score -gt 30 ]];then
	echo "初窥门径"
else
	echo "初学乍练"
fi
