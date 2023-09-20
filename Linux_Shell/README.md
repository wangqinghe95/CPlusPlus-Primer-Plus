# Shell 脚本要点记录

1. 判断某个文件是否存在
```
conf_file=/etc/vsftpd.conf
[ ! -e $conf_file ] && echo '$conf_file don't exist'
[ -e $conf_file ] && echo '$conf_file exist'
```
+ -e 用来检查文件是否存在，若存在返回真，若不存在返回假

2. 备份文件
```
cp $conf_file{,.bak}
```
+ Bash 大括号扩展，能将 $conf_file{,.bak} 扩展为 $conf_file $config_file.bak

3. 查看指定文件中某个关键字是否存在，如果不存在，则增加
```
grep -q local_root /etc/vsftpd.conf || sed '$a local_root=/common' /etc/vsftpd.conf
```
+ grep -q 静默搜索，不显示在屏幕上
+ grep -q local_root /etc/vsftpd.conf：
    - 查看 /etc/vsftpd.conf 文件中是否包含 local_root 字段，如果包含，则不输出任何内容，如果未找到，则返回一个非零的状态码
+ ||：逻辑或运算符
    - 如果前面的命令的执行失败，即未找到关键字就执行下一句语句
+ sed '$a local_root=/common' /etc/vsftpd.conf：
    - 在文件末尾添加 local_root=/common 内容

4. 取消配置文件中的注释
```
sed -i 's/^#chroot_local_user=YES/chroot_local_user=YES/' /etc/vsftpd.conf
```
+ sed 
    - 流编辑器，对文本文件进行修改
+ -i
    - sed 的一个参数选项，可以直接修改源文件，而不是输出到标准输出中
- 's/^#chroot_local_user=YES/chroot_local_user=YES/'
    - 匹配所有以 #chroot_local_user=YES 开头的行修改为 chroot_local_user=YES，即取消注释
    - 该配置项表示 vsftpd 服务是否限制本地用户只能访问自己的主目录

5. 检查字符串变量是否为空
```
if [ -z $result ];then
    echo 'grep is empty'
else
    echo 'grep is not empty'
fi
```

+ -z 判断，如果为空，返回真，否则，返回假

6. ubuntu 添加账户
```
useradd $username
echo "$passwd" | sudo chpasswd $username &> /dev/null
```

7. 判断某个软件是否安装
```
result=$(which vsftpd)
if [ ! -z $result ]; then
    echo 'Vsftpd do not install'
else
    echo 'Vsftpd has installed'
fi
```

+ 脚本中是用 which/type，rpm -q 在 ubuntu 中不起作用
+ 简单的可以查看软件版本，比如 vsftpd -v,但是该方法在脚本中无法使用

8. 查看进程是否已经启动
```
ps -ef | grep [process_name]
service [process_name] status
```

9. 版本信息的获取
```
result=$(dhcpd -v 2>&1)
echo $result
```
+ 非系统软件的版本号不能直接赋值到变量中
+ 2>&1 标准错误输出重定向到标准输出

10. 注释掉某文件中包含指定关键字的行
```
# 注释掉含有关键字的行
sed -i '/[key_word]/s/^/#/' [file_path]
# 取消含关键字行的注释符号
sed -i '/[key_word]/s/^#//' [file_path]

# mysql 安装过程中，为了允许远程登陆，会将 bind-address 配置给注释掉
sed -i '/^bind-address/s/^/#/' /etc/mysql/mysql.conf.d/mysqld.cnf
# 取消注释
sed -i '/^bind-address/s/^#//' /etc/mysql/mysql.conf.d/mysqld.cnf
```

11. awk 从第二行开始，处理不以 + 号开头的行


