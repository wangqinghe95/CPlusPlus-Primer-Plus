# Linux_Shell 核心编程指南

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

| 符号 	| 含义 	|
|---	|---	|
| -eq 	| 相等 	|
| -ne 	| 不相等 	|
| -gt 	| 大于 	|
| -lt 	| 小于 	|
| -le 	| 小于或者等于 	|
| -ge 	| 大于或者等于 	|

2. 比较方法
    1. test 3 -eq e && echo Y || echo N
    2. [ 6 -eq 3 ] && echo Y || echo N
3. 使用样例
    1. grep Available /proc/meminfo | egrep -o "[0-9]+"
    2. ps aux | wc -l

### chapter 2-4 文件属性的判断和比较

1. 常用的文件操作符（Linux中万物都是文件）

| 操作符 	| 功能描述 	|
|---	|---	|
| -e file 	| 判断文件或目录是否存在，存在返回真，否则返回假 	|
| -f file 	| 判断存在且为普通文件 	|
| -d file 	| 判断存在且为目录 	|
| -b file 	| 判断存在且为块设备文件（如磁盘，U盘等设备） 	|
| -c file 	| 判断存在且为字符设备文件（如键盘、鼠标等设备） 	|
| -L file 	| 判断存在且为软链接文件 	|
| -p file 	| 判断存在且为命名管道 	|
| -r file 	| 判断存在且当前用户对该文件具有可读权限 	|
| -w file 	| 判断存在且当前用户对该文件具有可写权限 	|
| -x file 	| 判断存在且当前用户对该文件具有可执行权限 	|
| -s file 	| 判断存在且文件大小非空 	|
| file1 -ef file2 	| 两个文件使用相同设备、相同inode编号，则返回真，否则返回假 	|
| file1 -nt file2 	| file1比file2更新1时返回真；或者file1存在而file2不存在时返回真 	|
| file1 -ot file2 	| file1比file2更旧时返回真；或者file2存在而file1不存在时返回真 	|

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

### chapter 2-6 系统性能监控脚本

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

3.  [[]] 与 [] 比较

| [[]]测试 	| []测试 	|
|---	|---	|
| < 排序比较 	| 不支持（仅部分Shell解释器支持\<） 	|
| > 排序比较 	| 不支持（仅部分Shell解释器支持\>） 	|
| && 逻辑与 	| -a 逻辑与 	|
| \|\| 逻辑或 	| -o 逻辑或 	|
| == 模式匹配 	| == 字符匹配 	|
| =~ 正则匹配 	| 不支持 	|
| () 分组测试 	| \(\)仅部分Shell解释器支持分组测试 	|

### chapter 2-7 单分支 if 语句

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
    + Nmap 常用选项

    | 选项 	| 功能描述 	|
    |---	|---	|
    | -sP 	| 仅执行ping扫描 	|
    | -sT 	| 执行针对TCP的端口扫描 	|
    | -sS 	| 执行针对TCP的半开扫描 	|
    | -sU 	| 执行针对UDP的端口扫描 	|
    | -n 	| 禁止DNS反向解析（默认会对扫描对象进行反向DNS解析） 	|
    | -p 	| 指定需要扫描的特定端口号 	|

3. crontab : 定期执行程序的命令
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

        | command 	| explain 	|
        |---	|---	|
        | contrab -e 0 6-12/3 * 12 * /usr/bin/backup 	| 在12月内，每天 6:00-12:00，每隔3个小时执行一次 /usr/bin/backup 	|
        | crontab -e 0 17 * * 1-5 mail -s "hi" alex@domain.com 	| 周一到周五每天下午 5:00 寄一封信给 <alex@domain.com> 	|
        | crontab -e 20 0-23/2 * * * echo "haha" 	| 每天的从 00:20 开始，每隔 2 小时就执行一次 echo "haha" 	|
        | crontab -e 0 */2 * * *  /sbin/service hhtpd restart 	| 每两小时开启一次apache 	|
        | crontab -e 50 7 * * * /sbin/service sshd start 	| 每天 7:50 开启 ssh 服务 	|
        | crontab -e 50 22 * * * /sbin/service sshd stop 	| 每天 22:50 关闭 ssh 服务 	|
        | crontab -e 0 0 1,15 * * fsck /home 	| 每月 1 号和 15 号检查 /home 盘 	|
        | crontab -e 1 * * * * /home/bruce/backup 	| 每小时的第一分执行 /home/bruce/backup 这个文件 	|
        | crontab -e 00 03 * * 1-5 find /home "*.xxx" -mtime +4 -exec rm {} \; 	| 每周一到周五 3 点钟，在目录 /home 下，查找文件名为 "*.txt" 文件，并删除 4 天前的文件 	|
        | crontab -e 30 6 */10 * * 15 ls 	| 每月的 1，11，21，31 日的 6:30 执行一次 ls 	|


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
    2. cURL 常用的有效名称
    

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
|----|---|
|*|匹配任意字符串|
|?|匹配任意单个字符串|
|[...]|匹配括号中的任意单个字符串|

2. 扩展通配符

|扩展通配符|描述|
|----|----|
|?(pattern_list)|匹配一次或者零次指定的模式列表|
|?(pattern_list)|匹配一次或者多次指定的模式列表|
|*(pattern_list)|匹配零次或者多次指定的模式列表|
|@(pattern_list)|仅匹配一次指定的模式列表|
|!(pattern_list)|匹配指定模式列表之外的所有内容|

3. shopt: 查看所有变量
    + shopt -s extglob: 激活指定的控制变量
    + shopt extglob: 仅查看一个变量
    + shopt -u extglob: 禁用指定的控制变量
