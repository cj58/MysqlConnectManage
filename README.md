# 1 功能介绍
    MysqlConnectManage是Linux是方便用户，记忆mysql连接信息和快速切换mysql连接到具体的数据库的一个小工具。
    采用shell脚本编写。源码目录：https://github.com/cj58/MysqlConnectManage。

# 2 安装MysqlConnectManage
```
#创建项目目录
# mkdir -p /home/dev/svn/avatar/MysqlConnectManage

#下载源码 
# wget https://github.com/cj58/MysqlConnectManage/archive/master.zip

#解压
# unzip master.zip

#将代码拷贝到项目目录
# cp MysqlConnectManage-master/* /home/dev/svn/avatar/MysqlConnectManage -r
```


# 3 使用
## 3.1 新建一个数据库连接
```bash
# cd /home/dev/svn/avatar/MysqlConnectManage
# sh mysql_connect.sh 
```
输入你系统连接的数据库主机或者IP(Host or IP)，端口(Port)，用户名(User)，密码(Password)。
![新建立一个连接](https://github.com/cj58/img/blob/master/MysqlConnectManage/newconn.png)

## 3.2 选择一个已有数据库连接
```bash
# cd /home/dev/svn/avatar/MysqlConnectManage
# sh mysql_connect.sh 
```
如果输入0，这时候会走3.1 新建一个数据库连接流程。如果输入1，会直接连接这个数据库。
![选择一个已有数据连接](https://github.com/cj58/img/blob/master/MysqlConnectManage/choice.png)

## 3.3 快速进入一个已有数据库连接
```bash
# cd /home/dev/svn/avatar/MysqlConnectManage
# sh mysql_connect.sh 1
```
sh mysql_connect.sh 脚本上带上你想要连接的数据数字比如：sh mysql_connect.sh 1，则会快速连接1对应的数据信息。
![快速连接](https://github.com/cj58/img/blob/master/MysqlConnectManage/fastchoice.png)

## 3.4 批量导入连接信息
每次新建一个连接都会保存在脚本mysql_connect_config.cnf中。可以直接便捷这个文件/home/dev/svn/avatar/MysqlConnectManage/mysql_connect_config.cnf。输入你系统的连接的数据库连接信息。
```
mysql -h ffffccoasdfasdfuntdev1-db -P 3306 -uhxxxxxf -pxxxx.com
mysql -h recoasdfasdfverdb1-dev.bj1.xxxx.net -P 3306 -uhxxxxxf -pxxxx.com
mysql -h systsfsdfsfemdev1-db.bj1.xxx.net -P 3306 -uhxfffxx -pxxxx.com
mysql -h sdfsfsdf-db -P 3306 -uhxfxxxx -pxxxx.com
mysql -h wesfadfihu1-db.bj1.xxx.net -P 3306 -uhxsdfsfxxxxx -pxxxx.com
```
