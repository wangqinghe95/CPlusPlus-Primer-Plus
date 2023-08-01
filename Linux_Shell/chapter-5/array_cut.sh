#!/bin/bash

tools=(car helicoper airplane train)

# 提取数组中的某个元素
echo ${tools[0]}

# 对数组某个元素进行截取
echo ${tools[0]:0:2}
echo ${tools[1]:0:2}

# 掐头操作
echo ${tools[1]#*e}
echo ${tools[1]##*e}

# 去尾操作
echo ${tools[1]%e*}
echo ${tools[1]%%e*}
