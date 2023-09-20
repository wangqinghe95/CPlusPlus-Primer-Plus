# Command for mysql

## Mysql Command
1. mysql 检测
```
mysqladmin -u'[use_name]' -p'[password]' ping
# 无密码检测
mysqladmin -u'root'  ping
# 有密码检测
mysqladmin -u'root' -p'user000' ping
mysqladmin -u'root' -p'user000' -hlocalhost ping
```

2. 查看所有数据库连接线程列表
+ mysqladmin -uroot -puser000 processlist
    + 可用查询什么账户从哪台主机正在链接数据库服务器，正在使用的数据库名称，该账户正在执行的 SQL 指令是什么 等信息
3. 查询所有数据库名称列表
+ mysql -uroot -puser000 -e "SHOW DATABASES"
    + -e 参数可以非交互式地执行各种 SQL 指令
4. show variables 指令可以查看数据库管理系统的各种变量及值
    + mysql -uroot -puser000 -e "SHOW VARIABLES LIKE 'max_connections'"
        + 在所有变量中查找 max_connections 变量及其值，查看数据库的最大并发连接数
    + mysql -uroot -puser000 -e "SHOW VARIABLES LIKE 'max_user_connections'"
        + 在所有变量中查找 max_user_connections 变量及其值，查看每个用户最大并发连接数
    + mysql -uroot -puser000 -e "SHOW VARIABLES LIKE '%connections%'"
        + 支持通配符进行模糊匹配，查看所有与 connections 有关的参数
5. show status 查看数据库系统的实时状态信息
    + mysql -uroot -puser000 -e "SHOW STATUS LIKE 'Threads_connected'"
        + 查看当前实时客户端的连接数
    + mysql -uroot -puser000 -e "SHOW STATUS LIKE 'Max_used_connections'"
        + 查看曾经的最大客户端连接数
    + mysql -uroot -puser000 -e "SHOW STATUS LIKE 'com_select'"
    + mysql -uroot -puser000 -e "SHOW STATUS LIKE 'com_insert'"
    + mysql -uroot -puser000 -e "SHOW STATUS LIKE 'com_update'"
    + mysql -uroot -puser000 -e "SHOW STATUS LIKE 'com_delete'"
    + mysql -uroot -puser000 -e "SHOW STATUS LIKE 'slow_queries'"
        + 查看 select/insert/update/delete/slow_queries 指令被执行的次数
    + mysql -uroot -puser000 -e "SHOW STATUS LIKE 'Questions'"
        + 查看服务器执行的总指令数，不包括存储过程
    + mysql -uroot -puser000 -e "SHOW STATUS LIKE 'uptime'"
        + 查看数据库软件启动时间
    + mysql -uroot -puser000 -e "SHOW STATUS LIKE 'Com_commit'"
    + mysql -uroot -puser000 -e "SHOW STATUS LIKE 'Com_rollback'"
        + 查看数据库执行 commit 指令的次数
6. QPS & TPS
    + QPS：每秒查询量，总指令数/uptime
    + TPS 每秒事物量，（事务 commit + 事务 rollback）/uptime，（Com_commit+Com_rollback）/ uptime
    

## mysql 安装
1. 打开终端，输入：
```
sudo apt-get updata
```

2. 更新完毕后，输入
```
sudo apt-get install mysql-server

```
+ ubuntu14.04安装中间会让你设置密码，输入密码后点击确认(mysql123)

3. 安装结束后，查看 mysql 服务是否启动
```
systemctl status mysql
```
+ 如果出现 Active: active (running) 表示已经运行

4. 修改配置文件，允许远程用户登录本机数据库
+ 在 mysql 配置文件夹下查找关键字 bind-address
```
grep -r "bind-address" /etc/mysql/
# search result
# /etc/mysql/mysql.conf.d/mysqld.cnf:bind-address=127.0.0.1
```
+ 在上述步骤中找到的文件中注释掉该行,如上
```
sudo sed -i '/^bind-address/s/^/#/' /etc/mysql/mysql.conf.d/mysqld.cnf
```

5. 配置mysql汉字字符编码为utf-8
+ 在 mysql 配置文件的 [mysqld] 字段下方加入
```
character-set-server = utf-8
skip-name-resolve
```

+ 方法1：直接使用 vim 打开文件
```
# 查看 [mysqld] 所在的配置文件
grep -r "mysqld" /ect/mysql
# /etc/mysql/mysql.conf.d/mysqld.cnf:[mysqld]
# vim 打开文件找到 mysqld 的行，在该行后添加
```
+ 方法2：使用 sed 命令直接添加
```
# 找到 [mysqld] 关键字所在的配置文件
grep -r "mysqld" /ect/mysql
# 查看该关键词在该文件中的行号
cat -n /etc/mysql/mysql.conf.d/mysqld.cnf | grep "mysqld"
# result
#  27  [mysqld]
# 在 该文件中的第 28 行后加入上述配置
sed -i "40i character-set-server = utf-8\nski
p-name-resolve" /etc/mysql/mysql.conf.d/mysqld.cnf
# 需要注意的是，使用 sed 命令插入如果出现操作失误，会直接导致源文件无法还原，所以在用命令操作之前最好做个备份
cp [file]{,.bak}
cp /etc/mysql/mysql.conf.d/mysqld.cnf{,.bak}
```

6. 确认配置并重启mysql
```
# way 1
systemctl restart mysql.service
# way 2
service mysql restart
```

7. 登陆 mysql
```
mysql -u[user_name] -p[password]
mysq -uroot -pmysql123
```
mysql -uroot -pmysql123

8. 给远程主机登陆的 root 用户授予所有权限
```
grant all privileges on *.* to 'root'@'% ' identified by 'mysql123' with grant option;
```

8. 重新加载授权表
```
flush privileges；
```

9. 验证字符设置是否成功
```
#进入mysql
mysql -uroot -pmysql123
#输入
show variables like ‘%character%’;
#查看出现的字符设置是否都是utf-8
```

10. quit退出，安装完成。

11. 卸载 mysql
```
sudo apt-get autoremove mysql* --purge
sudo apt-get remove apparmor
sudo rm /var/lib/mysql/ -R
sudo rm /etc/mysql/ -R
```