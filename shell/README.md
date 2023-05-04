# Shell 脚本编程

## chapter 1

### chapter 1-1 脚本文件的书写格式

1. 以 #!/bin/bash 开头
2. 单行注释以 # 开头，多行注释以 <<[STRING] [STRING] 格式

### chapter 1-2 脚本的执行方式

1. 脚本执行方法
    1. ./[script_name]
    2. source [script_name]
    3. bash [script_name]
    4. sh [script_name]
    5. . [script_name]
2. 注意文件执行权限
3. pstree 查看进程树
4. 脚本运行的方法中，方法 1/3/4 会在 bash 进程中再起一个子进程来运行脚本，而 2/5 则直接在当前进程中运行脚本

### chapter 1-3 输入输出

#### echo

1. echo [string] 输出打印信息
    + string 会以空格为分隔符分为多个条目
    + 引号内部的内容会被认为是一个条目
    + 转义字符需要加参数 -e 才能被识别
    + 可以通过转移字符控制输出的大小，颜色，格式等字体属性

#### printf

1. printf 的用法可以等同认为是 C/C++ 中的printf用法
    + 支持输出格式
    + 支持输出宽度

#### read

1. read 从标准输入读取一行数据
    + read [options] [variable]
    + options:
        1. -p: 显示提示信息
        2. -t: 设置读入数据的超时时间
        3. -n: 设置读取 n 个字符后结束
        4. -r: 支持读取 \
        5. -s: 静默模式

### 1-4 输入输出重定向

### 1-5 引号使用

1. 单引号引起来的内容被视为一个整体，不被引起来的内容会被空格分为分成若干个条目
2. 双引号引起来的内容可以转义，单引号的转移字符会被直接打印
    + \ 字符也可以转移，只能转移一个字符，双引号内的所有转义字符都会被翻译
3. 反引号是命令替换字符，可以在双引号中使用单引号引入命令的执行
4. 反引号和单引号容易混淆，不支持嵌套，所以有 $() 可以代替单引号的命令替换功能

## 1-6 变量

1. 变量定义时等号两边不能有空格
    + 变量名称是由字母，数字和下划线构成，且不能由数字开头
    + 读取变量使用符号 '$'
    + 变量和非变量在一起时（没有空格隔开），需要使用 ‘{}’分割
    + 取消变量定义，可以使用unset删除
2. 常见的系统预设变量
    + UID: 当前账户的ID号
    + USER: 当前账户的名称
    + HISTSIZE: 当前终端的最大历史命令条目数量
    + HOME: 当前账号的根目录
    + LANG: 当前环境使用的语言
    + PATH：命令搜索路径
    + PWD: 当前工作路径
    + RANDOM: 随机返回 0-32767 的整数
    + $0: 返回当前命令的名称
    + $n: 返回位置参数，$1表示第一个参数，数字大于9时必须使用${n}
    + $#: 命令参数的个数
    + $@: 命令行的所有参数
    + $?: 返回上一条命令退出时的状态码（一般来说0表示正确，非0表示失败）
    + $$: 返回当前进程的进程号
    + $!: 返回最好一个进程的进程号

## 1-7 grep

1. grep
    + 查看关键字并打印匹配的行
    + grep [options] pattern [file]
        + options:
            1. -i: 忽略大小写
            2. -v: 取反匹配
            3. -w: 匹配单词
            4. -q: 静默匹配，不将结果显示在屏幕上
    + 正则表达式及其含义
        + c: 匹配字母c
        + .: 陪陪单个任意字符
        + *: 匹配前一个字符出现零次或者多次
        + .*: 匹配多个任意字符
        + []: 匹配集合中的任意单个字符，括号可以是任意数字字母的集合
        + [x-y]: 匹配连续的字符串范围
        + ^: 匹配字符串开头
        + $: 匹配字符串结尾
        + [^]: 匹配否定，对括号内的集合取反
        + \: 匹配转义后的字符串
        + \{n,m\}: 匹配前一个字符重复 n 到 m 次
        + \{n,\}: 匹配前一个字符至少 n 次
        + \{n\}: 匹配前一个字符 n 次
        + \(\): 将\(\)之间的内容存储在“保留空间”，最多存储9个
        + \n: 通过 \1到 \9调用保留空间中的内容
    + 样例
        + grep "root" /tmp/passwd
            + 在/tmp/passwd 文件中查找包含root的行
        + grep ":..0:" /tmp/passwd
            + 在/tmp/passwd 文件中查找符合字符'0'与字符"0:"之间包含任意两个字符条件的行
        + grep "00*" /tmp/passwd
            + 在/tmp/passwd 文件中查找至少包含一个0的行（第一个0必须出现，第二个0可以出现0次或者多次）
        + grep "o[os]" /tmp/passwd
            + 在/tmp/passwd 文件中查找 oot 或者 ost 的行
        + grep "[0-9]" /tmp/passwd
            + 在/tmp/passwd 文件中查找包含数字的行
        + grep "[f-q]" /tmp/passwd
            + 在/tmp/passwd 文件中查找包含字母f~q的行，（范围内任意字符都可）
        + grep "bash$" /tmp/passwd
            + 在/tmp/passwd 文件中查找以bash字符串结尾的行
        + grep "sbin/[^n]" /tmp/passwd
            + 在/tmp/passwd 文件中查找 sbin/ 后不跟字母 n 的行
        + grep "0\{1,2\}" /tmp/passwd
            + 在/tmp/passwd 文件中查找数字 0 出现次数在[1,2]次之间的行
        + grep "\(root\).*\1" /tmp/passwd
            + 在/tmp/passwd 文件中查找有两个root的行
        + grep "^$" /tmp/passwd
            + 在/tmp/passwd 文件中过滤空白行

2. 计算
    + 常见的运算符号：等同C/C++
    + let 进行数字运算
        + let 运行不会直接显示，需要保持到变量中
    + 小数运算需要使用 bc 命令

## chapter 2

### chapter 2-1 智能化脚本测试的基础

1. shell 中条件判断的方法
    + [[expression]]、[expression]、test
    + 条件表达式可以测试文件属性，进行字符或者数字比较
2. 条件判断不会有默认结果输出
    + echo $? 查看上一条命令的退出码
        + 0 运行成功，非 0 运行失败
    + && 或者 || 结合上一条命令进行结果的输出操作
3. 表达式两边需要有空格
    + 在 [[]] 和 test 进行排序比较时，使用的比较符不同
    + test 和 [] 中不能直接使用 <> 进行排序比较
4. A 命令;B 命令
    + 先执行 A 命令，再执行 B 命令，整个命令的退出码以 B 命令为准
5. A 命令 && B 命令
    + 先执行 A 命令，如果 A 命令执行成功，则执行 B 命令，如果 A 命令失败，则不执行 B 命令
    + 若 AB 命令都执行成功，则退出码为 0，否则为非 0
6. A || B
    + A 执行成功则不执行 B，否则执行 B
    + 两条命令有一条返回 0，则返回0，否则返回 1

### chapter 2-2 字符串的判断和比较

1. 字符串判断和比较的方法
    + 使用 test 和 [], 效果等同
2. 常用的字符串运算符
    1. = : 检查两个字符串是否相等，相等返回 true
    2. != : 检查两个字符串不想等，不想等返回 true
    3. -z : 检查字符串长度是否为 0， 为 0 返回 true
    4. -n : 检查字符串长度不为 0，不为 0 返回 true
    5. $ : 检查字符是否不为空， 不为空返回 true

### chapter 2-3 整数的判断与比较

1. 常用的整数比较运算符
    1. -eq = equal: 相等
    2. -ne = not equal: 不想等
    3. -gt = greater than: 大于
    4. -ge = greater than or equal: 大于或者等于
    5. -lt = less than: 小于
    6. -le = less or equal: 小于或者等于
2. 比较方法
    1. test 3 -eq e && echo Y || echo N
    2. [ 6 -eq 3 ] && echo Y || echo N
3. 使用样例
    1. grep Available /proc/meminfo | egrep -o "[0-9]+"
    2. ps aux | wc -l

### chapter 2-4 文件属性的判断和比较

1. 常用的文件操作符（Linux中万物都是文件）
    1. -e [string_name]: 判断文件或者目录是否存在，存在返回真，否则返回假
    2. -f [string_name]: 判断文件是否存在，存在返回真，否则返回假
    3. -d [string_name]: 判断文件夹是否存在，存在返回真，否则返回假
    4. -b [string_name]: 判断块设备是否存在（磁盘，U盘等设备）
    5. -c [string_name]: 判断字符设备是否存在（键盘，鼠标等设备）
    6. -L [string_name]: 判断软链接是否存在）
    7. -p [string_name]: 判断管道设备是否存在
    8. -r [string_name]: 判断文件是否存在并且当前用户对该文件是否具有读权限
    9. -w [string_name]: 判断文件是否存在并且当前用户对该文件是否具有写权限
    10. -x [string_name]: 判断文件是否存在并且当前用户对该文件是否具有执行权限
    11. -s [string_name]: 判断文件是否存在并且文件大小是否为空
    12. [file1] -ef [file2]: 两个文件是否相同（使用相同设备，inode相同），是则返回真，否则返回假
    13. [file1] -nt [file2]: file1比file2更新时返回真
    14. [file1] -ot [file2]: file1比file2更旧时返回真
2. 样例
    1. [ -e file_1 ] && echo Y || echo N
    2. [file_1 -ef file_2 ] && echo Y || echo N

### chapter 2-5 [] 与 [[]] 的区别

1. 区别：
    + test 或者 [] 符合 POSIX 标准的测试语句，兼容性更强，几乎可以运行在所有 shell 解释器中
    + [[]] 仅可运行在特定的几个 shell 解释器中，如 bash 或者 Zsh，此外 [[]] 内部可以是使用正则表达式
    + [[]] 表达式中 > 和 < 表示排序比较的意思，使用的是本地的locale语言顺序
        + 如果指定 LANG=C（ASCII 标准码的顺序中，小写字符 > 大写字母 > 数字）
    + [[]] 中可以直接使用 && 和 || 逻辑运算符，而 [] 中需要使用 -a 和 -o 表示 与 和 或 逻辑运算符
    + 在 [[]] 中 == 是模式匹配，允许使用通配符
    + [[]] 中支持正则匹配

## chapter 2-6 系统性能监控脚本

1. mail
    + 发送邮件的命令
    + 需要安装
        + sudo apt-get install mailutils
    + 使用方式：
        + mail -s "[mail_subject]" [mail_address] << "[mail content]"
        + echo "[mail content]" | mail -s "[mail_subject] [mail_address]
2. vmstat: virtual memory statistics
    + 输出说明：
        1. r: 正在运行的队列，如果该值过大表示 CPU 使用率很高
        2. b: 阻塞的进程，正在等待资源的进程数，比如正在等待的 I/O，或者内存交换
        3. swap: 虚拟空间使用的大小；大于 0 表示物理内存不足，或者内存泄露
        4. free: 空闲的物理内存大小；
        5. buff: 块设备读写时使用到的缓存
        6. cache: 文件系统的 cache。如果该值过大，表示打开的文件较多
        7. si: 每秒从磁盘读入虚拟内存的大小，如果该值大于 0，表示物理内存不够用了或者内存泄露
        8. so: 每秒从虚拟内存写入到磁盘中的大小
        9. bi: 块设备每秒接收的块数量，这里的块设备是指系统上所有磁盘和其他块设备。
        10. bo: 块设备每秒发送的块数量，读取文件时，bo就会大于 0.
        11. in: 每秒 CPU 的中断次数，包括时间中断
        12. cs: 每秒上下文的切换
        13. us: 用户 CPU 时间
        14. sy: 系统 CPU 时间，如果数值过高，表示系统调用时间过长
        15. id: 空闲 CPU 时间
        16. wt: 等待 IO、CPU时间
    + 常见的命令格式：
        + vmstat [-a] [-n] [-S unit] [delay [count]]
        + vmstat [-s] [-n] [-S unit]
        + vmstat [-m] [-n] [delay [count]]
        + vmstat [-d] [-n] [delay [count]]
        + vmstat [-p disk partition] [-n] [delay [count]]
        + vmstat [-f]
        + vmstat [-V]
    + 参数说明
        + -a: 显示活跃和非活跃的内存
        + -f: 显示从系统启动到此刻的 fork 数量
        + -m: 显示 slabinfo
        + -n: 只在开始时显示一次各字段名称
        + -s: 显示内存相关统计信息及多种系统活动数量
        + delay: 刷新时间间隔。默认显示一条结果
        + count: 刷新次数，默认一直刷新
        + -d: 显示磁盘的相关统计

## chapter 2-7 单分支 if 语句

1. 语法格式

```
if [condtion_expreesion]
then
    [code]
fi
```

or

```
if [condtion_expreesion];then
    [code]
Fi
```

### 2-8 单分支 if 语句

1. systemctl
    + systemctl is-active [service]: 查看服务是否启动
    + systemctl is-enabled [service]: 查看服务是否是开机自启项
2. 查看系统某个软件是否已经安装
    + which [program_name]
    + whereis [program_name]
3. wget 下载软件到指定目录
    + wget -c [download_addree] -P [folder_path]

### 2-9 如何监控 HTTP 服务状态

1. nmap 监测主机是否存活并且可以检测端口是否打开
    + nmap [option] [scan_list]
    + option:
        + -sP: 仅执行 ping 扫描
        + -sT: 仅针对 TCP 端口扫描
        + -sS: 仅针对 TCP 端口半开扫描
        + -sU: 仅针对 UDP 端口扫描
        + -n: 禁止 DNS 反向解析
        + -p: 指定需要的扫描的特定端口
2. crontab : 定期执行程序的命令
    + crontab -e [timer_parameter] [program]
    + timer_parameter:
        + timer_parameter 的参数是 f1 f2 f3 f4 f5 program
        + 分钟，小时，一个月份的第几天，月份，一个星期天的第几天
        + 每分钟执行一次：*****
        + 每小时执行一次：0****
        + 每天定时执行一次：00***
        + 每周定时执行一次：00**0
        + 每个月定时执行一次：001**
        + 每月最后一天定时执行一次：00L**
        + 每年定时执行一次：0011*
    + example：
        1. `0 6-12/3 * 12 * /usr/bin/backup`
            + 在12月内，每天 6:00-12:00，每隔3个小时执行一次 /usr/bin/backup
        2. `0 17 * * 1-5 mail -s "hi" alex@domain.com`
            + 周一到周五每天下午 5:00 寄一封信给 alex@domain.com
        3. `20 0-23/2 * * * echo "haha"`
            + 每天的从 00:20 开始，每隔 2 小时就执行一次 echo "haha"
        4. `0 */2 * * *  /sbin/service hhtpd restart`
            + 每两小时开启一次apache
        5. `50 7 * * * /sbin/service sshd start`
            + 每天 7:50 开启 ssh 服务
        6. `50 22 * * * /sbin/service sshd stop`
            + 每天 22:50 关闭 ssh 服务
        7. `0 0 1,15 * * fsck /home`
            + 每月 1 号和 15 号检查 /home 盘
        8. `1 * * * * /home/bruce/backup`
            + 每小时的第一分执行 /home/bruce/backup 这个文件
        9. `00 03 * * 1-5 find /home "*.xxx" -mtime +4 -exec rm {} \;`
            + 每周一到周五 3 点钟，在目录 /home 下，查找文件名为 "*.txt" 文件，并删除 4 天前的文件
        10. `30 6 */10 * * 15 ls`
            + 每月的 1，11，21，31 日的 6:30 执行一次 ls
    + 如果在 crontab 中无法执行脚本，而shell终端直接没有问题的话，主要是因为环境变量无法读取的问题
        + 解决方法，有以下三种
            1. 所有命令需要写成绝对路径形式：
            2. shell脚本开头声明环境变量

                ```
                    #!/bin/bash
                    . /etc/profile
                    . ~/.bash_profile
                ```

            3. 在 /etc/crontab 中添加环境变量，在可执行命令之前添加命令 . /etc/profile;/bin/sh, 使环境变量生效如
                `20 03 * * * . /etc/profile;/bin/sh /var/www/runoob/test.sh`
3. curl: 命令行的文件传输工具
    1. 语法格式：
        + curl [option] URL

4. parted: 磁盘操作
    + parted [options] [disk [operation_command]]
    + [operation_command]:
        1. help: 查看帮助
        2. mklabel [LABEL_TYPE]: 新建分区表
        3. mkpart PART-TYPE [FS-TYPE] START END: 新建分区
        4. rm NUMBER: 删除分区
    + example：
        + parted /dev/sdc mklabel gpt
            + 新建GPT分区表格式
        + parted /dev/sdc print
            + 查看磁盘分区信息

### 2-11 简单高效的case语句

1. case
    + ;; 等同于 break
    + ;;& 等同于没有 break
    + ;& 等同于命中下一行的命令

### 2-13 模式匹配与通配符、扩展通配符

1. 通配符
    |通配符|描述|
    |*****|****|
    |*|匹配任意字符串|
    |?|匹配任意单个字符串|
    |[...]|匹配括号中的任意单个字符串|
2. 扩展通配符
    |扩展通配符|描述|
    |*********|****|
    |?(pattern_list)|匹配一次或者零次指定的模式列表|
    |?(pattern_list)|匹配一次或者多次指定的模式列表|
    |*(pattern_list)|匹配零次或者多次指定的模式列表|
    |@(pattern_list)|仅匹配一次指定的模式列表|
    |!(pattern_list)|匹配指定模式列表之外的所有内容|
3. shopt: 查看所有变量
    + shopt -s extglob: 激活指定的控制变量
    + shopt extglob: 仅查看一个变量
    + shopt -u extglob: 禁用指定的控制变量
    
