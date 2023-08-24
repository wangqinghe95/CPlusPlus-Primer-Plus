# Linux_Shell 核心编程指南

## chapter 3

### chapter 3-1 for循环

1. 格式1

```
for [variable_name] in [word...]
do
    [code]
done
```

2. 格式2

```
for [variable_name]
do
    [code]
done
```

+ 此时默认的取值为 $@, 即所有位置变量的值。传入参数的值
+ word 支持多种拓展，比如变量替换，命令拓展，算术拓展，通配符拓展

3. shell 扩展

+ {} 扩展
    1. echo {1..5}
    2. echo {5..1}
    3. echo {1..10..2}
    4. echo {a..z}
    5. echo {A..Z}
    6. echo {x,y{i,j}{1,2,3},z}
+ seq
  + seq 1 5
  + seq -s' ' 1 5
  + seq 2 2 10
  + seq -s' ' 8   # 不指定起始位置，默认从1开始
  + i=5,j=10,seq -s' ' $i $j

4. passwd
    + 非交互式的添加/修改
        + echo "[user_name]:[user_passwd]" | chpasswd
5. 格式3

```
for ((expr1; expr2; expr3))
do
    [code]
done
```

### chapter 3-5 非常重要的IFS

+ IFS
  + shell 使用内部变量 (internal Field Seprator)来决定项目列表或者值列表哦的分割符；
  + IFS 的默认值为空格、Tab制表符或换行符。
  + 在使用 for 循环读取项目列表或者值列表时，就会根据 IFS 的值判断列表中值的个数，最终决定循环次数。
  + IFS 中多个值之间的关系是 “或”
  + IFS 设置为默认的空格，tab制表符，或换行符
    + IFS=$' \t\n'

### chapter 3-6 while 循环

+ 格式

```
while [condition]
do
    [code]
Done
```

### chapter 3-9 until 和 select 循环

1. until 循环

+ 格式

```
until [condition]
do
    [code]
done
```

+ 条件判断为真退出，与 while 的退出条件正好相反

2. select 循环

+ 主要是方面的创建菜单

+ 格式

```
select [variable_name] in [value_list]
do
    [code]
done
```

### chapter 3-10 中断和退出机制

+ continue: 结束本次循环
+ break: 结束当前循环体
+ exit: 退出脚本
