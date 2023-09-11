# awk 使用
+ awk 是一种处理文本文件的编程言语，默认以空格或制表符为分隔符，每条记录会被分为若干字段（列），awk 每次从文件中读取一条记录
+ awk [option] 'condition1{action} condition2{action} ... ... ' [file] ...

## 7.1 awk 基础语法
### 内置变量
+ awk 语法是由一系列条件和动作组成，在花括号内可以有多个动作，每个动作之间使用分号分割，在多个条件和动作之间可以有若干个空格
+ awk 会逐行扫描以读取文件内容，从第一行到最后一行，寻找与条件匹配的行，并对这些匹配的数据执行特定的动作。
+ 条件可以是正则匹配、数字和字符串比较，动作可以是打印需要过滤的数据或者其他，如果没有指定条件，则可以匹配所有数据行，如果没有指定动作则默认为 print 打印操作
+ 因为 awk 是逐行处理软件，所以这里的动作默认隐含循环，条件被匹配多少次，动作就会执行多少次

### 常用 awk 内置变量

|变量名|描述|
|---|---|
| FILENAME | 当前输入文档的名称 |
| FNR | 当前输入文档的当前行号，尤其当有多个输入文档时有效 |
| NR | 输入数据流的当前行号 |
| $0 | 当前行的全部数据内容 |
| $n | 当前行的第 N 个字段 |
| NF | 当前记录（行）的字段（列）的个数 |
| FS | 字符分隔符，默认空格或 tab 制表符 |
| OFS | 输出字符分隔符，默认为空格 |
| ORS | 输出记录分隔符，默认为换行数 \n |
| RS | 输入记录分隔符，默认为换行符 \n |

### 自定义变量
1. awk 可以通过 -v 选项设置或者修改变量的值，使用 -v 定义新的变量，也可以使用该选项修改内置变量的值
    + awk -v x="Jacob" -v y=11 '{print x,y}' [filename]
2. 使用内置的系统变量，通过 -v 选项或者组合多个引号实现
    + x="hello"
    + awk -v i=$x '{print i}' test1.txt
    + awk '{print "'$x'"}' test1.txt
    + awk -v FS=":" '{print $1}' test2.txt
3. 使用 [] 设置多个分隔符集，同时设置多个分隔符。如[:,;]以表示冒号，逗号横线作为分隔符
    + awk -v FS="[:,-]" '{print $1}' test2.txt
4. 直接使用 -F 选项指定数据字段的分隔符
    + awk -F: '{print $1}' test2.txt
    + awk -F"[:,-]" '{print $2}' test2.txt
5. RS 保存的是输入数据的记录分隔符，也就是行分隔符，默认 \n 换行符。通过修改 RS 的值同样可以指定其他字符为记录分隔符
    + awk -v RS="," '{print $1}' test1.txt
6. 内置变量OFS保存的是输出字段的分隔符，默认为空格，而变量ORS保存的是输出记录的分隔符，默认为换行符，可以使用 -v 修改
    + awk '{print $3,$1,$3}' test1.txt
    + awk -v OFS=":" '{print $3,$1,$3}' test1.txt
    + awk 是逐行处理软件，默认在读取第一行数据并输出该行内容后，会自动在其后追加一个 \n 换行符，接着处理后续的其他数据行。但是如果修改了 ORS 变量的值，也可以将换行的分隔符修改为其他字符。
### print 指令
1. 使用 print 指令输出特定数据时，可以输出变量数据，同时也还可以直接输出常量，如果是字符串常量需要使用双引号，如果是数字常量可以直接打印。

### 条件匹配
1. awk 支持使用正则进行模糊匹配，也支持字符串和数组的精准匹配，并支持逻辑与和逻辑或

| 比较符号 | 描述 |
|---|---|
| // | 全行数据正则匹配 |
| !// | 对全行数据正则匹配后取反 |
| ~// | 对特定数据正则匹配 |
| !~// | 对特定数据正则匹配后取反 |
| == | 等于 |
| != | 不等于 |
| > | 大于 |
| >= | 大于等于 |
| < | 小于 |
| <= | 小于等于 |
| && | 逻辑与 |
| || | 逻辑或 |

2. 默认的正则匹配
+ awk '/world/{print}' test1.txt 
    + 打印包含 world 的行
    + awk '/world/' test1.txt 
+ awk '$2~/the/' test1.txt
    + 对每行的第二列进行正则匹配
+ awk '$3~/never/{print $1,$4,$5}' test1.txt
    + 第三列匹配 never 关键词，包含则打印该行的 1，4，5 列
+ awk '$4=="to"' test1.txt
    + 精准匹配 to
+ awk -F: '$3<10{print $1}' /etc/passwd
    + 匹配 /etc/passwd 文件，以 : 号分割行，第三列数字小于 10 的行，打印其第三列
+ awk 'NR==4' /etc/passwd
    + 打印第 4 列数据
+ awk -F: '$3>1&&$3<5' /etc/passwd
    + 打印第三列中满足两个条件的行

3. BEGIN和END
+ BEGIN 和 END 可以是 awk 匹配的条件。
    + BEGIN 会导致动作指令仅在读取任何数据记录之前执行一次，END 会导致动作指令尽在读取完所有数据记录后执行一次。
    + 利用 BEGIN 可以进行数据初始化操作，END 进行数据的汇总操作
+ awk 'BEGIN{print "OK"}' /etc/passwd
+ awk 'END{print NR}' /etc/passwd
+ awk -F: 'BEGIN{print "User UID Interpretation"} {print $1,$3,$7}  END {print "There are "NR" counts in total."}' /etc/passwd
+ awk 可以通过算术运算符进行数字运算
    + awk 'BEGIN{print 2+3}'
    + awk 'BEGIN{print 10-4}'
    + awk 'BEGIN{print 2*3}'
    + awk 'BEGIN{x=8;y=2;print x**y}'
+ awk 中变量不需要定义就可以直接使用，作为字符串处理时未定义的变量默认值为空，作为数字处理时未定义的变量默认值为 0
    + awk 'BEGIN{print "["x"]","["y"]"}'
    + awk '/bash$/{x++} END{print x}' /etc/passwd
        + 逐行读取 /etc/passwd 文件，匹配以 bash 结尾的行时执行 x++，否则跳过
+ who | awk '$1=="root"{x++} END{print x}'
+ seq 200 | awk '$1%7==0 && $1~/7/'
    + 打印 1~200 之间所有能被 7 整除并且包含 7 的数字
+ df | tail -n +2 | awk '{sum+=$4} END{print sum}'
    + 所有文件系统剩余容量的总和
+ ls -l /etc/*.conf | awk '{sum+=$5} END{print sum}'
    + 统计 /etc 文件夹下以 .conf 文件数量
+  ls -l /etc/*.conf | awk '/^-/{sum+=$5} END{print "Total number:"sum"."}'
    + 统计 /etc 目录下文件数量


## 7.2 awk 条件判断
+ 单分支
```
if(condition){
    action;
}
```
+ 双分支
```
if(condition){
    action1;
}
else{
    action2;
}
```
+ 多分支
```
if(condition1){
    action1;
}
else if(condition2){
    action2;
}
....
else{
    actionN;
}
```

### 单分支 if 语句的案例
1. 查看 CPU 百分比占用率超过指定数值的进程
+ ps -eo user,pid,pcpu,comm | awk '{ if($3>0.5) {print} }'
2. 查看内存占用较大的进程
+ ps -eo user,pid,rss,comm | awk '{ if($3>1024) {print} }'

### 双分支 if 语句案例
1. awk -F: '{if($3<1000){x++}else{y++}} END{print "The Number of User:"x,"The Number of Normal User:"y}' /etc/passwd
    + PID 小于 1000 的为系统用户，否则为普通用户
2. ls -l /etc | awk '{if($1~/^-/) {x++} else {y++}} END {print "The number of file:"x,"The number of Folder:"y}'
    + 统计 /etc 目录下，普通文件和目录文件个数
3. seq 10 | awk '{if($1%2==0) {print $1" is Even";x++} else {print $1" is Odd";y++}} END{print "The number of Even:"x, "The number of Odd:"y}'

### 多分支
+ awk '{if($2>=90){print $1,"\tPerfect"} else if($2>=80) {print $1,"\tExcellent"} else if($2>=70){print $1,"\tGood"} else if($2>=60) {print $1,"\tEligibile"} else {print $1,"\tGeneral"}}' score.txt

## 7.3 awk 数组与循环
### 关联数组
+ awk 支持关联数组，数组的索引下标可以不是连续的数组，索引下标可以是任意字符或数组，当使用数组作为索引时 awk 会自动将数字转换成字符，如果直接使用字符做索引则需要使用引号括起来。
```
#one dimensional array
array_name[index]=value

## more dimensional array
array_name[index1][index2]=value
or
array_name[index1,index2]=value
```

+ 直接使用数组名+索引下标即可调用数组的值。因为数字索引会被自动转换为字符，所以在定义数组使用数字的情况下，调用数组时也可以使用字符的形式调用。
    + awk 'BEGIN{a[0]=11;print a[0]}'
    + awk 'BEGIN{a[0]=11;a[10]=22;print a[10],a[0]}'
    + awk 'BEGIN{tom["age"]=22; tom["addr"]="beijing"; print tom["age"],tom["addr"] }'
    + awk 'BEGIN{ a[0][0]=11;a[0][1]=22; print a[0][1],a[0][0] }'
    + awk 'BEGIN{ a["a"]["a"]=11;a["a"]["b"]=22; print a["a"]["b"],a["a"]["a"] }'

### 循环
1. 如果数组有多个元素，可以使用 for 循环获取数组元素的索引下标，然后在循环体中将数组元素取出，格式如下：
```
for (variable in array){
    action
}
```
+ awk 'BEGIN{ a[10]=11;a[88]=22;a["book"]=33;a["work"]="home"; for(i in a){print i}}'
    + 循环的方式取出数组，此时取出的数据顺序是无序的

2. 判断一个索引是否存在为数组成员，语法格式如下：
```
for(index in array)
```
+ awk 'BEGIN{ a[88]=55;a["book"]="pen"; if("pen" in a){print "Yes"} else {print "No"} }'

3. for 循环
+ awk 的 for 循环可以采用与 C 语言一样的语法格式
```
for(expression1;expression2;expression){
    action    
}
```
+ awk 'BEGIN{ for (i=1;i<=5;i++) {print i}}'

4. 处理不规则的数据时，可以使用循环逐一处理所有数据
+ awk '{ for(i=1;i<=NF;i++) {if($i~/apple/) x++ } } END {print x}' for_circle.txt
+ awk '{for(i=1;i<=NF;i++) {if($i=="is") x++ }} END{print x}' for_circle.txt

5. while 循环
+ 同 C while 循环
```
while(condition){
    action;
}
```

6. 中断循环
+ continue、break、exit 循环中断语句

## 7.4 awk 函数
### 内置 I/O 函数
1. getline: 可以让 awk 立刻获取到下一行数据（读取下一条记录并且赋值给 $0,并且重置 NF、NR、FNR）
+ df -h | awk '{if(NF==1){getline;print $3}; if(NF==6){print $4} }'
    + NF 当前行有多少列
2. next: 函数可以停止处理当前的输入记录，立刻读取下一条记录并返回awk 程序的第一个模式匹配重新处理数据
    + getline 仅仅读取下一条数据，而不会影响 awk 执行
    + next 会直接跳过 awk 后续的指令
3. system([command]): 直接在 awk 中调用 shell 命令
    + 会启动一个新的进程去执行命令

### 内置数值函数
1. cos(expr)：返回 expr 的 cosine 值
2. sqrt(expr)：返回 expr 的平方根
3. int(expr)：返回 expr 整数部分数值
4. rand: 返回 0~1 之间的随机值
5. srand([expr]): 使用 expr 定义新的随机数种子，没有 expr 是使用当前系统时间作为随机数种子

### 内置字符串函数
1. length([s]): 统计字符串 s 的长度，如果不指定字符串 s 则统计 $0 的长度
2. index(s1,s2): 返回字符串 s2 在字符串 s1 中的坐标位置
3. mathc(s,r): 根据正则表达式 r 返回其所在字符串 s 中的坐标位置
4. tolower(str): 将字符串转换成小写
5. toupper(str): 将字符串转换成小写
6. split(str,array,c): 将字符串按照特定的分隔符切片后存储到数组中，默认分隔符为 FS 定义的
7. gsub(r,s,[,t]): 将字符串 t 中所有与正则表达式 r 匹配的字符串替换成 s，默认字符串为 $0
8. sub(r,s,[,t])：同 sub，仅替换第一个匹配的字符串

### 内置时间函数
1. systemtime(): 返回当前时间距离1970-01-01 00:00:00 有多少秒

### 用户自定义函数
+ awk 用户自定义函数格式如下：
```
function [name](parameter_list){
    actions;
}
```

## 7.5 awk 版网站日志分支
1. 查看 nginx 服务是否开启
    + sudo systemctl status nginx
2. awk '{IP[$1]++} ./access.log'
    + awk 读取日志文件的第一行，定义关联数组，数组名为 IP，使用该行的第一列数据作为数组的索引下标，即 ip 地址 127.0.0.1, IP[127.0.0.1]++ 对该数组元素进行自加 1 运算，因为默认该数组元素的值为 0，自加 1 后表示当前 ip 地址被访问一次
    + 接着取第二行数组，重复步骤一过程
    + awk '{IP[$1]++} END{for(i in IP){print i,IP[i]}}' ./access.log
3. 条件匹配
    + awk -F"[: /]" '$7":"$8>="21:53"&&$7":"$8<="21:57"' access.log

## 7.6 监控网络状态
1. ss 命令
    + 实时查看网络链接状态
    + ss 语法格式：
        + ss [option]
    + ss 命令常用选项

    |命令选项|功能描述|
    |---|---|
    | -H | 不显示标题行 |
    | -n | 以数字格式显示信息，不尝试解析服务名称 |
    | -a | 显示所有侦听和非侦听的链接状态 |
    | -p | 显示进程信息 |
    | -s | 显示汇总信息 |
    | -4 | 仅显示 IPv4 版本数据链接信息 |
    | -6 | 仅显示 IPv6 版本数据链接信息 |
    | -t | 显示 TCP 链接的信息 |
    | -u | 显示 UDP 链接的信息 |
    | -x | 显示 Unix sockets 信息，主要用于同一台主机进程之间的通信 |

    + ss 命令
