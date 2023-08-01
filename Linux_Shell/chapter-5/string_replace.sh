#!/bin/bash

# 列出以 U 开头的所有变量名
echo ${!U*}

# 同上
echo ${!U@}

# 列出以 HO 开头的所有变量名
echo ${!HO@}

test1=(11 22 33 44)
test2=(77 88 99 00)

# 返回数组下标
echo ${!test2[*]}
echo ${!test2[@]}

# 定义关联数组
declare -A str
str[a]=AAA
str[b]=bbb
str[word]="key value"

# 查看数组中所有的内容
echo ${str[*]}

# 列出所有数组下标 C++中 map 中的 key
echo ${!str[*]}
echo ${!str[@]}

play="Go Super Go"

# 统计变量的长度，包括空格
echo ${#play}

hi=(hello the world)
# 默认统计 hi[0] 的长度
echo ${#hi}
echo ${#hi[0]}
echo ${#hi[1]}
echo ${#hi[2]}

phone=18811811811

# 将 1 替换成 x，仅替换第一个
echo ${phone/1/x}
# 将 1 替换成 x，替换所有
echo ${phone//1/x}

# 将 110 替换成 x，仅替换第一个
echo ${phone/110/x}
# 将 110 替换成 x，替换所有
echo ${phone//110/x}

lowers="hello the world"

# 将首字母替换成大写
echo ${lowers^}
# 将所有字母替换成大写
echo ${lowers^^}
# 变量替换不会修改变量的值
echo $lowers

# 将第一个 h 替换成大写
echo ${lowers^h}
# 将所有的 h 替换成大写
echo ${lowers^^h}

# 将字母 h,e,o 替换成大写
echo ${lowers^^[heo]}


uppers="HELLO THE WORLD"
# 将首字母替换成小写
echo ${uppers,}
# 将所有字母替换成小写
echo ${uppers,,}
# 将第一个的 H 换成小写
echo ${uppers,H}
# 将所有的 H 换成小写
echo ${uppers,,H}
# 将字母 H,O,L 替换成大写
echo ${uppers,,[HOL]}