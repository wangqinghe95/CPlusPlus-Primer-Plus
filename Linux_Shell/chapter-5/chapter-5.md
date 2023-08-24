# Linux_Shell 核心编程指南

## chapter-5

### chapter 5-1 花括号的扩展

1. 花括号中包含一组以分号分割的字符或者字符串序列组成的一个字符串扩展,最终的结果是以空格分开
    + echo {r,f,j}
    + echo {hello, jacob}
    + echo {22,33,56,87}
    + echo {a..z}
2. 字符串序列后面可以跟一个可选的步长整数，默认值为 1 或者 -1
    + echo {a..z..2}
    + echo {a..z..3}
    + echo {1..9..2}
3. 花括号扩展不能使用引号
    + echo "{1..9..2}"
    + echo "{a..z}"
4. 花括号扩展时可以在花括号前和后添加可选的字符串，并且花括号支持嵌套
    + echo t{i,o}p
    + echo t{o,e{a,m}}p
5. 利用扩展，备份文件
    + cp /test/at.txt{,.bak}
6. 利用扩展重命名
    + mv /test/bt.txt{,bt.doc}

### chapter 5-2 波浪号扩展

1. ~ 在shell中默认代表当前用户的家目录
2. ~+ 表示当前目录
3. ~- 表示当前目录的上一层

### chapter 5-3 变量替换

1. shell 中使用 $ 对变量进行拓展替换，变量字符可以放到花括号中，可以防止需要扩展的变量字符与其他不需要扩展的字符混淆
2. 如果 $ 后面跟的是数字，且数字的长度大于1，则需要{}将后续的内容包括起来
3. ! 可以实现变量的间接引用， ! 必须放到{}内
    + echo player="DUNCAN"
    + echo mvp=player
    + echo ${!mvp}
        + DUNCAN
4. ${[value]:-[key_word]}
    + 如果变量未定义，或者值为空，则返回关键字。否则返回变量的值
5. ${[value]:=[key_word]}
    + 如果变量未定义或者值为空，则将关键字赋值给变量，并返回结果，否则直接返回变量的值
6. ${[value]:?[key_word]}
    + 如果变量未定义或者值为空，则通过标准错误显示包含关键字的错误信息，否则直接返回变量的值
7. ${[value]:+[key_word]}
    + 如果变量未定义，或者值为空，则直接返回空。否则返回变量的值

8. 字符串切割和掐头去尾具体语法

|语法格式|功能描述|
|------|------|
| ${变量:偏移量} | 从变量的偏移量开始，切割截取变量的值到结尾|
|${变量:偏移量:长度}|从变量的偏移量开始，切割特定长度的变量值。变量的偏移量的起始值为0|
|${变量#关键字}|使用关键字对变量进行模式匹配，从左往右删除匹配的内容，关键字可以使用*符号。使用#匹配时为最短匹配(最短匹配掐头)|
|${变量##关键字}|同上，最长匹配|
|${变量%关键字}|使用关键字对变量进行模式匹配，从右往左删除匹配的内容，关键字可以使用*符号。使用%匹配时为最短匹配(最短匹配去尾)|
|${变量%%关键字}|同上，最长匹配去尾|

9. 变量内容的统计与替换

| 语法格式 	| 功能描述 	|
|---	|---	|
| ${!前缀字符*} 	| 查找以指定字符开头的变量的名称，变量名之间以IFS分割 	|
| ${!前缀字符@} 	| 查找以指定字符开头的变量的名称，@在引号中将被扩展为独立的单词 	|
| ${!前缀字符[*]} 	| 列出数组中的所有下标，*在引号中会被扩展成一个整体 	|
| ${!前缀字符[@]} 	| 列出数组中的所有下标，@在引号中会被扩展成独立的单词 	|
| ${#变量} 	| 统计变量的长度，变量可以是数组 	|
| ${变量/旧字符串/新字符串} 	| 将变量中的旧字符串替换成新字符串，仅替换第一个 	|
| ${变量//旧字符串/新字符串} 	| 将变量中的旧字符串替换成新字符串，替换所有 	|
| ${变量^匹配字符} 	| 将变量中的小写字母替换成大写字母，仅替换第一个 	|
| ${变量^^匹配字符} 	| 将变量中的小写字母替换成大写字母，替换所有 	|
| ${变量,匹配字符} 	| 将变量中的大写字母替换成小写字母，仅替换第一个 	|
| ${变量,,匹配字符} 	| 将变量中的大写字母替换成小写字母，替换所有 	|

### chapter 5-4 命令替换

1. $() 与 ``

### chapter 5-5 算术替换

1. 算术替换
    + 通过算术替换扩展可以进行算术计算并返回计算结果
    + 算术替换扩展的格式为 $(()),也可以使用 $[] 的形式
    + 算法扩展支持嵌套
2.example
    + echo $((i++))
    + echo $[++i]

### chapter 5-6 进程替换

1. 介绍
    + 进程替换将进程的返回结果通过命名管道的方式传递给另外一个进程
    + 一旦使用进程替换，系统将会在 /dev/fd 目录下创建文件描述符，通过该文件描述符将进程的输出结果传递给其他进程
2. 语法格式
    + <(Command) 或者 >(Command)
3. 效果
    + 使用进程我们可以将多个进程的输出结果传递给一个进程作为其输入参数。

4. paste: 逐行读取多个文件的内容并将多个文件合并
    + paste <(cut -d: -f1,6 /etc/passwd) <(cut -d: -f2 /etc/passwd)
5. tee: 将内容重定向到文件中
    + ls | tee <(grep sh$ > sh.log) <(grep conf$ > conf.log)

### chapter 5-7 单词切割

1. shell 使用 IFS 变量进行分词处理，默认使用 IFS 变量的值作为分隔符，对输入数据进行分词处理后执行命令。

### chapter 5-8 路径替换

1. 除非使用 set -f 禁用路径替换，否则 Bash 会在路径和文件名中对 * ? [ 符号进行模式匹配的替换
2. 若 shopt 命令开启了 nocaseglob 选项，则 Bash 在模式匹配时不区分大小，默认是区别大小写
3. shopt 命令开始 extglob，可以支持 拓展通配符
4. example
    + touch a{1,2,3,4}.txt
    + rm -rf a[1-4].txt

### chapter 5-10 解释器的属性与初始化命令行终端

1. set 和 shopt 查看和设置 Bash 特性
2. set -o
    + 开启和关闭特定的 Bash 属性
    + set 常用命令属性
        | 属性 	| set选项 	| 功能描述 	|
        |---	|---	|---	|
        | allexport 	| [+-]a 	| 将函数和变量传递给子进程（默认关闭） 	|
        | braceexpand 	| [+-]B 	| 支持花括号扩展（默认开启） 	|
        | errexit 	| [+-]e 	| 当命令返回非0值时立刻退出（默认关闭） 	|
        | hashall 	| [+-]h 	| 将该命令位置保存到Hash表（默认开启） 	|
        | histexpand 	| [+-]H 	| 支持使用!对历史命令进行扩展替换（默认开启） 	|
        | noclobber 	| [+-]C 	| Bash使用重定向操作符>、>&和<>时，不会覆盖已存在的文件，<br>可以使用>\|绕过该限制（默认关闭） 	|
        | noexec 	| [+-]n 	| 仅读取命令，不执行命令，仅在脚本中有效（默认关闭） 	|
    + example
        + allexport 
            ```
            test=123    # 定义局部变量
            bash        # 开启子进程
            echo $test  # 子进程无法获取父进程变量
            exit        # 退出父进程

            set -a      # 开启 allexport
            test=123
            bash
            echo $test  # 子进程可以获取父进程变量
            exit
            set +a      # 关闭 allexport
            ```
        +  braceexpand
            ```
            echo {a..c}     # 默认支持花括号扩展
            set +B          # 关闭花括号扩展
            echo {a..c}     
            set -B          # 开启花括号扩展
            ```
        + hash
            + hash -d [key_word]: 删除hash表中[key_word]的记录
            + hash -r: 清空 hash 表
3. shopt -s/-u
    + 开启和关闭

### chapter 5-11 trap 信号捕获
1. trap：
    + trap 命令是用于 Linux shell 脚本中指定如何处理信号。他用于监视和拦截 shell 脚本中应该处理的 Linux 信号。
    + trap 的命令格式为：
        + trap [command] [signal]
        + 其中 [command] 是当 shell 收到指定的 [signal] 后应该被执行的命令
    + example
        + trap "echo 'Terminated..'; exit 1" SIGTERM
        + 当 shell 脚本收到 SIGTERM 信号后，会打印 "Terminated..." 并且退出码为 1 
2. tput: 
    + tput 更改终端功能，比如移动或更改光标，更改文本属性，以及清除终端屏幕的特定区域
    + 光标属性：
        + tput clear 
            + 清屏
        + tput sc
            + 保存当前光标位置
        + tput cup 10 13
            + 将光标移动到 row col
        + tput civis
            + 光标不可见
        + tput cnorm
            + 光标可见
        + tput rc
            + 显示输出

### chapter 5-14 脚本排错技巧
1. bash +x [script]
2. echo 打印
3. 单独执行命令验证

### chapter 5-15 Shell 版本的进度条功能
1. \r
    + 将光标移动至行首，但不换行
    + echo -e "abc\r12"
    + i=5 && printf "|%s%${i}s|" abc
2. printf
    1. printf "%10s" xyz
        + 指定输出宽度为10，不足则补空格，长度超过则按照实际长度显示
    2. printf "%.2s" xyz
        + 指定显示宽度为2，超过则剪裁掉超出部分
    3. printf x; printf "\b%s" yz
        + 显示字符 x，删除x后再显示字符 y
3. 实现动态指针
    1. rotate='|/-\'
    2. echo ${rotate#?}
    3. echo ${rotate%???}
    4. rotate=${rotate#?}${rotate%???}
    5. echo ${rotate}
    6. rotate=${rotate#?}${rotate%???}
    7. echo ${rotate}

### chapter 5-16 传输传递 xargs
1. 很多程序不支持使用管道传递参数，比如find，cut
    + cut -d: -f1 /etc/passwd | echo
    + find /etc/ -name *.conf -type f | echo
2. 有一些程序命令可以命令参数中读取输入的数据，无法从管道中读取数据
    + cat /var/run/crond.pid  | kill    # 报错
    + echo /tmp/test.txt | rm           # 报错
3. xargs 可以读取标准输入或者管道中的数据， 并将这些数据传递给其他程序作为参数
    + cut -d: -f1 /etc/passwd | xargs       # 默认程序是 echo
    + find -name "*.txt" | xargs grep "line"    # 过滤查找的文件（过滤的内容是文件内部的内容）
    + find -name "*.txt" | xargs ls -al         # 查看文件详细内容信息
4. 而xargs读取参数时以空格、tab制表符或者回车符为分隔符和结束符，但是有些文件名本身可能包含空格，此时xargs会理解一个文件有多个参数
    + find 命令会在输出找到的文件吗后自动添加一个换行符
    + find 提供 print0 选项，设置 find 在输出文件后自动添加一个 NULL 来替代换行符
    + xargs 提供了一个 -0(数字零)选项，指定使用 NULL 而不是空格，Tab 制表符或者换行符作为结束符
    + 这样对于 xargs 来说空格就变成了一个普通字符，只有 NULL 才被识别为参数的结束符
    + touch "hello world.ext" "ni hao.txt"
    + find ./ -name "*.txt" -print0 | xargs -0 rm
5. xargs 可以通过 -a 从文件中读取参数传递给其他程序
    + xargs -a /ect/hostname
6. xargs 可以通过 -n 选项一次性读取几个参数，默认读出所有值
    + seq 5 | xargs -n 2
7. xargs 可以通过 -d 选项指定任意字符为分隔符，默认以空格，tab制表符或换行符为分隔符
    + echo "helloatheaworld" | xargs -da
8. xargs 可以通过 -I 选项指定一个替换字符串，xargs 会用读到的参数替换掉这个替换字符串
    + touch {a,b,c}.txt
    + ls *.txt | xargs -I[] cp [] /tmp/
    + rm -rf /tmp/{a,b,c}.txt

### chapter 5-17 使用shift移动位置参数
+ shift
    + 可以左移位置参数，shift 命令后面需要一个非负整数作为参数，如果没有指定该参数，默认1
    + 通过 shift 命令可以很方便的读取所有位置的参数