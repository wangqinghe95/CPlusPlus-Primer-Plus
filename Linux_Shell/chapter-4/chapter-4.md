# Linux_Shell 核心编程指南

## chapter 4 数组、subshell、函数

### chapter 4-1 数组

+ 数组的格式

```
[array_name][index]="[string_content]"
[array_name]=(value_1 value_2 value_3 ...)
```

2. 查看数组元素

+ 查看指定索性元素
  + $([array_name][index])
  + index 是负值的话表示倒数
+ 查看数组所有元素的个数
  + $(#[array_name][*])
+ 查看数组所有元素的值
  + $([array_name][@]): 数组中的每个元素被视为一个个体
  + $([array_name][*]): 数组中的所有元素视为一个整体
+ 数组的索引是一个变量

3. $()和 `` 可以将命令的执行结果赋值给数组变量

4. BASH 4.0 版本以后提供了一个新的关联数组，类似于C++的结构体

```
declare -A [array_name]
[array_name][[mem]]=[string]
```

### chapter 4-4 subShell

1. subshell
    + 通过当前的 shell 启动一个新的子进程，或者子 shell 的过程被称为 subshell
    + 子 shell 会继承父 shell 的环境变量，如变量，工作目录，文件描述符等
    + 子 shell 中的环境变量父 shell 无法继承使用
    + 启动子 shell
        1. ()
        2. &
        3. 管道符 |
        4. $()
    + 可以通过 shell 变量 BASH_SUBSHELL 中查看子 shell 的信息
        + 该变量初始化为 0， 每启动一个子 shell 该变量的值会自动 +1

2. 使用重定向文件的方式避开subshell结果无法在父shell页面中无法使用的问题
    + 执行外部命令或者加载其他脚本也会开启子 shell
    + 当一个脚本文件去调用另一个脚本的时候，使用 source 加载

### chapter 4-5 创建进程的若干种方式

1. shell 中执行命令创建进程的几种方式
    + fork:调用外部脚本时，系统会fork一个进程执行脚本。
    + exec：不会产生一个子 shell，而是使用新的程序替换当前的 shell 环境，exec 结束后，当前环境会被关闭
        + 为了防止当前脚本被覆盖，一般都会将 exec 写入到另一个脚本中
        + 先使用 fork 的方式调用该脚本，然后在 fork 的子进程中调用 exec 命令
        + 例外的就是当 exec 后面的参数是文件重定向时，不会替换当前 shell 环境，脚本后续的其他命令不会收到影响
    + source
        + 不开启子 shell 执行命令

### chapter 4-6 非常实用的函数功能

1. 格式

```
// 方式一
[function_name](){

}
// 方式二
function [function_name](){

}
// 方式三
function [function_name]{

}
```

### chapter 4-7 变量的作用域与return返回值

1. 变量的作用域
    + 无论是函数内部还是函数外部，定义的变量都默认为全局变量
    + 如果想要设置一个变量的作用域为当前函数的话，使用 local 关键字
2. 全局变量和局部变量
    + 函数外部定义的数组和关联数组是全局变量
    + 函数内部定义的数组是全局变量，内部定义的关联数组是局部变量
3. 函数返回值
    + 默认整个函数的状态码为函数内部最后一个命令的返回值
    + return 自定义函数返回值，return 让函数立刻中断返回
    + exit 不仅会中断函数，还会中断整个脚本

### chapter 4-8 多进程的 ping 脚本

1. wait [process_id]
    + 等待指定的进程返回，如果未指定进程号，则默认等待当前 shell 中所有子进程结束

### chapter 4-9 文件描述符和命名管道

1. /proc/[process_id]/fd/
    + 查看进程拥有的所有文件描述符
    + $$: 指定当前文件

2. exec: 手动自定义文件描述符
    + exec [file_descriptor] <> [file_name]
    + example input:
        1. touch test.txt
        2. 创建仅可输出的文件描述符
            + exec 12>test.txt
        3. 通过 &12 调用文件描述符
            + echo hello >&12
            + echo "world" >&12
        4. 关闭文件描述符
            + exec 12<&-
    + output:
        1. 创建仅可输入的文件描述符
            + exec 13<test.txt
        2. 通过 cat 读取该文件描述符
            + cat <&13
        3. 关闭文件描述符
            + exec 13<&-
    + output/input
        1. 创建可输入输出的文件描述符
            + exec 14<>test.txt
        2. 通过 cat 读取该文件描述符
            + cat <&14
        3. 通过 &42 调用文件描述符写入数据
            + echo "Rock" >&14
        4. 关闭文件描述符
            + exec 14<&-
    + Notice:
        1. 注意在使用 exec 的时候，数据会覆盖就有数据
        2. 使用追加方式 exec [file_descriptor]>>[file_name]

3. read
    + read -u: 每次读取一行数据
    + example：
        + echo "line1
            > line2
            > line3" > new.txt
        + exec 12<new.txt
        + read -u12 content
        + echo $content
            + line1
        + read -u12 content
        + echo $content
            + line2
        + read -u12 content
        + echo $content
            + line3
        + exec 12<&-
    + Notice:
        + 文件描述符包含一个文件很多信息，比如权限，文件偏移量等；
        + 文件偏移量像一个指针，指向文件的某个位置，默认是文件的起始位置
        + 当使用 read 命令后，该指针指向下一行数据，每次使用 read，指针都会移动一行；
    + read -u[file_descriptor] -n[numer] [file_number]: 指定读取的字符数
    + 创建文件描述符时，如果文件描述符对应的文件不存在，则系统会自动创建一个新的空文件

4. 命名管道
    + 系统提供的命名管道（C++用的也是同一个系统函数
