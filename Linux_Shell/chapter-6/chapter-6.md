# sed
1. sed 是一个流编译器，基于交互式行编译 ed 开发的软件。两者都是行处理编辑器。
2. sed 中搞清楚需要编辑哪一行内容很重要

## 6.1 sed 基本指令
1. sed 介绍
    + sed 会逐行扫描输入的数据，并将地区的数据内容复制到缓冲区中，我们称之为模式空间
    +  拿模式空间的数据与给定的条件进行匹配
        + 如果匹配成功则执行特定的 sed 指令 
        + 否则 sed 会跳过输入的数据行，继续读取后续的数据
    + 默认的情况下 sed 会将最终的结果通过标准输出显示在屏幕上
2. sed 语法格式
    + command | sed [option] 'conditions and operation'
    + sed [option] 'condition and operation' file...
3. 常用命令
    + sed 常用的命令选项
        | 命令选项 	| 功能描述 	|
        |---	|---	|
        | -n,-silent | 屏蔽默认输出功能，默认sed会将匹配到的数据显示到屏幕上	|
        | -r         |  支持拓展正则 |
        | -i[SUFFIX] | 直接修改源文件，如果设置了SUFFIX后缀名，sed 会将数据备份 |
        | -e    |   指定需要执行的 sed 指令，支持使用多个 -e 参数 |
        | -f    |   指定需要执行的脚本文件，需要提前将 sed 指令写入到文件中 |
    +   sed 基本操作
        | 基本操作指令  | 功能描述  |
        |---|---|
        | p | 打印当前匹配数据行    |
        | l | 小写 L，打印当前匹配的数据行（显示控制字符，如回车符等）  |
        | = |  打印当前读取的数据行数   |
        | a text | 在匹配的数据行后面追加文本内容   |
        | i text | 在匹配的数据行前面直接文本内容   |
        | d | 删除匹配的数据行整行内容（行删除）  |
        | c text    |  将匹配的数据行整行内容替换成特定的文本内容   |
        | r [filename]  | 从文件中读取数据并追加到匹配的数据行后面  |
        | w [filename]  | 将当前匹配的数据写入到特定的文件中    |
        | q [exit code] | 立刻退出 sed 脚本 |
        | s/regexp/replace  | 使用正则匹配，将匹配到的数据特换成特定的内容  |
    + sed 支持的数据定位方法
        + sed 指令前需要先根据条件定位需要处理的数据行，如果没有指定定位条件，则默认 sed 会对所有数据行执行特定的指令。
        + sed 支持的数据定位方法
            | 格式  |   功能描述    |
            | number    |   根据行号匹配数据    |
            | first~step    |   从 first 行开始，步长为 step，匹配所有满足条件的数据行  |
            | $ |   匹配最后一行    |
            | /regexp/  | 使用正则表达式匹配数据行  |
            | \cregexpc |   使用正则表达式匹配数据行，C 可以是任意字符  |
            | addr1,addr2   | 直接使用行号定位，匹配从 addr1 到 addr2 的所有行  |
            | addr1，+N |   直接使用行号定位，匹配从 addr1 开始及后面的 N 行    |

        + sed 是逐行处理软件，我们可能输入了一条 sed 指令，但系统会将该指令应用在所有匹配的数据行上，因此相同的指令会被反复的执行 N 次，这取决于匹配到的数据有几行
4. examples:
    + sed 'p' /etc/hosts
        + 当没有指定条件时，默认会匹配所有数据行，因此 /etc/hosts 文件有多少行，p指令就会执行多少次，sed 读取文件第一行执行 p 指令将该行内容显示在屏幕上，接着读取文件的第二行继续执行 p 指令再将该行内容显示在屏幕上。
        + 每个数据会打印显示两次，是因为没有 p 指令，sed 会默认将读取到的数据显示在屏幕上，p 指令会在打印显示一次。
        + 使用 -n 参数关闭默认的输出功能
            + sed -n 'p' /etc/hosts
    + sed -n '1p' /etc/hosts
        + 仅显示文件的第一行
        + '2p' 显示文件的第二行
    + df -h | sed -n '2p'
        + sed 支持从管道读取数据
    + cat -n /etc/passwd /tmp/passwd    : 生产带行号的素材文件
        + sed -n '1,3p' /tmp/passwd
            + 显示文件的第1~3行
        + sed -n '1p;3p;6;' /tmp/passwd
            + 多条指令使用分号分割
        + sed -n '4,$p' /tmp/passwd
            + 显示第4行到末尾所有行
        + sed -n '3,+3p' /tmp/passwd
            + 显示第3行以及后面的3行
        + sed -n '1~2p' /tmp/passwd
            + 显示1,3,5...奇数行（步长为2）
        + sed -n '2~2p' /tmp/passwd
            + 显示2,4,6...偶数行（步长为2）
        + sed -n '$p' /tmp/passwd
            + 显示最后一行数据
        + sed -n '/root/p' /tmp/passwd
            + 匹配包含 root 的行并显示
        + sed -n '/bash$/p' /etc/passwd
            + 匹配以bash结尾的行并显示
        + sed -n '/s...:x/p' /tmp/passwd
            + 匹配以字母 s 开头，:x结尾，中间包含任意三个字符的数据行
        + sed -n '/[0-9]/p' /tmp/passwd
            + 匹配包含数字的行并显示
        + sed -n '/^http/p' /etc/services
            + 匹配以 http 开头的数据行
    + 默认 sed 不支持拓展正则，如果希望使用扩展正则，可以使用 -r 参数
        + sed -rn '/^(icmp|igmp)/p' /etc/protocol
            + 开启扩展正则功能
        + sed -n '\cUIDcp' /etc/login.defs
        + sed -n '\xbashxp' /etc/shells
        + sed -n '\1bash1p' /etc/shells
        + sed -n '\:bash:p' /etc/shells
        + sed -n '\,bash,p' /etc/shells
            + 正则匹配包含 bash 的行并显示
        + sed -n 'l' /etc/shells
            + 显示数据内容时打印控制字符
    + sed 程序可以使用 = 指令显示行号，结合条件匹配，显示特定数据行的行号
        + sed -n '/root/=' /etc/passwd
            + 包含显示root字符串的行号
        + sed -n '3=' /etc/passwd
            + 显示第三行的行号
        + sed -n '$=' /etc/passwd
            + 显示最后一行的行号
    + sed 支持使用 ! 对匹配的条件进行取反操作
        + sed -n '1!p' /etc/hosts
            + 显示除第一行外的所有行数据
        + sed -n '/bash/!p' /etc/hosts
            + 显示没有 bash 的行
    + sed -a 添加数据
        + sed '1a add test line' /tmp/hosts
            + 通过 a 参数添加新的数据，虽然下屏幕上的输出结果显示已经添加上了新数据，但是查看源文件并没有发生变化
            + 默认 sed 仅仅在缓冲区中修改数据并显示在屏幕上，但是源文件并没有发生变化
            + 如果希望直接修改源文件的话，可以使用 -i 参数，但是使用该选项修改文件以后，发生修改错误，数据无法被修复
        + sed -i.bak '2d' /tmp/hosts
            + 先将文件备份为后缀名称为 .bak 的文件，再修改源文件的内容
            + 将 /tmp/hosts 文件的第二行删除
        + sed '1i add new line' /tmp/hosts
            + 在第一行前面插入数据
        + sed -i '1i add new line' /tmp/hosts
            + 直接在修改源文件
        + sed '/new/a tmp line' /tmp/hosts
            + 正则匹配包含 new 的行后面添加新的 temp line 数据
            + a 或者 i 指令后面的所有内容都会被理解为需要添加的数据内容，因此不可以再写其他指令
        + sed 'd' /tmp/passwd
            + 删除全文
        + sed -i '/^$/d' /tmp/profile
            + 删除空白行
        + sed -i '/^$/d' /tmp/profile
            + 删除 # 号开头的行
        + sed -i '/local/d' /tmp/profile
            + 删除包含 local 的行
        + sed '2c modify line' /tmp/hosts
            + 将第 2 行替换为新的内容
        + sed 'c all modify'
            + 所有行替换为新内容
        + sed '/new/c line' /tmp/hosts
            + 匹配包含 new 的行，替换成 line
    + 通过 r 指令将其他文件的内容读取并存入当前需要编辑的文件中；w 指令则将当前编辑的文件内容另存到其他文件中，如果目标文件存在，则另存时会覆盖目标文件内容
        + sed 'r /etc/hostname' /tmp/hosts
            + 逐行读取 /tmp/hosts 文件内容，每读取一行内容执行一次 r 指令
            + 会出现 /tmp/hosts 每行内容下都会有一个 /etc/hostname 的内容
        + sed '1r /etc/hostname' /tmp/hosts
            + 仅在第一行追加主机名
        + sed '3r /etc/hostname' /tmp/hosts
            + 仅在第三行追加主机名
        + sed 'w /tmp/myhosts' /tmp/hosts
            + 将 /tmp/hosts 文件另存到 /tmp/myhosts 文件中
        + sed '1,3w /tmp/myhosts' /tmp/hosts
            + 仅将第 1~3 行另存为新文件，文件会被覆盖
    + Notes:
        + 一般不要在使用类似于 3q 之类的指令时同时使用 -i 选项，这样会导致 sed 使用读取出来的 3 行数据，写入并覆盖源文件，从而导致源文件中的所有其他数据全部丢失
    + 关键词替换
        + sed 's/hello/hi/' test.txt
            + 匹配 test.txt 文件中每行的第一个 hello 字符串替换成 hi
        + sed '1s/jello/hi/' test.txt
            + 匹配 test.txt 文件中第一行 hello 字符串替换成 hi
        + sed 's/o/O/' test.txt
            + 替换 test.txt 文件中每行的第一个 o 为 O
        + sed 's/o/O/g' test.txt
            + 替换 test.txt 文件中所有的 o 为 O
        + sed 's/o/O/2' test.txt
            + 替换 test.txt 文件中每行第二个 o 为 O
        + sed -n 's/e/E/2p' test.txt
            + 仅显示被替换的数据
        + sed -n 's/e/E/gp' test.txt
            + 全局替换并显示替换的数据
        + sed 's/jacob/vicky/i' test.txt
            + 在 s 替换指令的最后添加 i 标记可以忽略大小写，将 jacob 替换成 vicky
    + 使用 s 替换指令时如果同时添加了 e 标记，则表示将替换后的内容当成 shell 命令在终端执行一次。
        + echo "/etc/hosts" | sed 's/^/ls -l /e'
            + 将 /etc/hosts 替换成 ls -l /etc/hosts, 替换成命令终端执行 ls -l /etc/hosts
        + echo "tmpfile" | sed 's#^#touch /tmp/#e'
            + 将 tmpfile 替换成 touch /tmp/tmpfile, 替换成命令终端执行该命令
    + 正则替换
        + sed 's/the//' test.txt
            + 将 the 替换为空，即删除
        + echo '"hello" "world"' | sed 's/\".*\"//'
            + 匹配 " 开头， " 结尾和在其中间所有数据，并将其全部删除
        + echo '"hello" "world"' | sed 's/\"[^\"]*\"//'
            + 匹配第一个引号开始，中间不包括引号的任意其他字符（长度任意），最后是一个 " 结束的数据，当一行数据包含多个引号数据时，就可以仅仅匹配第一个双引号的数据
        + sed -r 's/^(.)(.*)(.)$/\3\2\1/' test.txt
            + 将每行首尾字符对调
            + 使用 () 将匹配的数据保留，在后面通过 \n 调用前面保留的数据。
                + 第一个 () 中保留的是每行开头的第一个字符 . 在正则表达式中表示任意的单个字符
                + 第三个 () 中保留的是每行结束的最后一个字符
                + 中间的 () 保留的是除首位字符外中间的所有字符，(.*) 在正则中表示任意长度的任意字符
    + 在使用 s 指令进行替换时，默认使用 / 作为替换符号，但是当需要替换的内容本身包含 / 时需要对替换内容中的 / 使用 \ 转义。为了解决该问题，sed 使用其他字符作为替换符号
        + sed 's/\/sbin\/nologin/\/bin\/sh/' /tmp/passwd
            + 修改的是缓存中的内容，文件的内容并没有被替换
            + 替换 /tmp/passwd 文档中所有 /sbin/nologin 为 /bin/sh
        + sed 's#/sbin/nologin#/bin/sh#' /tmp/passwd
        + sed 's,/sbin/nologin,/bin/sh,' /tmp/passwd
        + sed 'sx/sbin/nologinx/bin/shx' /tmp/passwd
            + 使用 s 指令的替换符号修改为其他字符
    + sed 命令可以使用分号或者 -e 选项两种方式在一行中编写多条指令。可以使用分号将多个指令分割，或者下多个 -e 参数后面添加 sed 指令，sed支持一个或者多个 -e 参数，如果将分号放到 {} 中还可以实现对指令进行分组
        + sed -n '1p;3p;5p' test.txt
        + sed -n -e '1p' -e '3p' test.txt
        + sed '/world/s/hello/hi/;s/the//' test.txt
            + 先找到包含有 world 的行，然后将该行的 hello 替换成 hi，然后在替换该文件中所有行的第一个 the 为空
        + sed '/world/{s/hello/hi/;s/the//}' test.txt
            + 将含有 world 的行中 hello 修改为 hi 并且删除掉 the
    + sed 指令脚本
        + sed -f 读取 sed 指令文件并实现多指令操作
        + sed -f script.sed test


## 6.2 sed 高级指令
1. sed 高级操作指令

|高级操作指令|功能描述|
|---|---|
| h | 将模式空间中的数据复制到保留空间中 |
| H | 将模式空间中的数据追加到保留空间中 |
| H | 将保留空间中的数据追加到模式空间中 |
| H | 将保留空间中的数据追加到模式空间中 |
| x | 将保留空间和模式空间中的数据对调 |
| n | 读取下一行数据到模式空间 |
| N | 读取下一行数据追击到模式空间 |
| /[source]/[dest]/ | 以字符为单位将源字符转化为目标字符 |
| :label | 为 t 或 b 指令定义 label 标签 |
| t label | 有条件的跳转到 label，如果没有 label 则跳转到指令的结尾 |
| b label | 跳转到 label，如果没有 label 则跳转到指令的结尾 |

+ sed 工作原理
    + sed 在对数据进行编译修改前需要先将地区的数据写入模式空间中
        + sed 除了有一个用于临时存储的模式空间，还设计一个保留空间
        + 保留空间中默认仅包含一个回车符。
    + 前面学习的 a,i,d,c,s 指令都仅用到了模式空间，而不会调用保留空间中的数据
        + 当使用特定指令时，如 h,g,x 时，才会用到保留空间中的数据
        + 在保留空间中默认包含一个回车符
    + 当使用 h 指令时，sed 会把模式空间中的所有内容复制到保留空间中，并将保留空间中原有的内容覆盖
        + 而如果使用 H 指令，则 sed 会将模式空间中的所有内容追加到保留空间中回车符的后面，保留空间中的回车符不会被覆盖。
        + 反向操作 g,G, 以及交换指令 x 用法类似
+ example:
    + sed '2h;5g' test.txt
        + 读取文件的第二行时将整行数据复制到保留空间，并将保留空间中原有的回车符覆盖了
        + 然后在读取第五行时将保留空间的数据覆盖掉模式空间中的数据
        + 也就是说第 2 行的内容，替换了原来的第五行内容
    + sed '2H;5G' test
        + 过程同上，但是本次使用的 G，会将保留空间的内容追击到第五行后面

## 6.3 自动化配置 vsftpd 脚本
1. dpkg 基于 Debian 的一个主要的包管理工具，用来安装，构建，卸载，管理 deb 格式的软件包，基本语法为 dpkg [options] [.deb package name], 其中 -l 参数介绍如下：
    + 第一列表示软件包状态
        - ii：已安装且配置完毕
        - rc：已删除但是配置文件还在
        - iU：已安装但是未配置
        - rH：已删除但是还残留文件
    + 第二列表示软件包名称
    + 第三列表示软件包版本
    + 第四列表示软件包架构
    + 第五列表示软件包简短描述
2. 获取第 N 个空格前的字符
    + echo $str | awk 'print $1'
    + echo $str | cut -d ' ' -f1

    