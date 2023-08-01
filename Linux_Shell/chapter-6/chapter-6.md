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
            + 先将文件悲愤为后缀名称为 .bak 的文件，再修改源文件的内容
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
        + 
    