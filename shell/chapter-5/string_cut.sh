#!/bin/bash

home="The oak tree, It was covered with yellow handkerchiefs"

# 从位置2开始截取到变量末尾
echo 'echo ${home:2}'
echo ${home:2}
echo 'echo ${home:14}'
echo ${home:14}

# 从位置 14 开始截取 6 个字符后结束
echo 'echo ${home:14:6}'
echo ${home:14}

#  从左向右删除匹配中的Th，
echo 'echo ${home#Th}'
echo ${home#Th}

echo 'echo ${home#The}'
echo ${home#The}

# 变量开头无法匹配oak，返回原值
echo 'echo ${home#oak}'
echo ${home#oak}

# 匹配 y 及其左边的所有内容并删除
echo 'echo ${home#*y}'
echo ${home#*y}

# 删除第一个 o 及其左边的所有内容
echo 'echo ${home#*o}'
echo ${home#*o}

## 从左向右匹配，找到最后一个 o 并删除及其之前的所有字符
echo 'echo ${home##*o}'
echo ${home##*o}

# 从右向左匹配，删除 efs
echo 'echo ${home%efs}'
echo ${home%efs}

# 从右向左删除，直到删除到 d 位置
echo 'echo ${home%d*}'
echo ${home%d*}

# 从右向左删除，删除到最后一个d
echo 'echo ${home%%d*}'
echo ${home%%d*}
