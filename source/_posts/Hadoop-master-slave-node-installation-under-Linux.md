---
title: Hadoop 主从节点 Linux 下的安装
author: LuckyStar
email: hasrimollony@gmail.com
toc: true
comments: true
readmore: false
hide: false
aplayer: false
hideTime: false
tags:
  - hadoop
  - linux
  - centos
categories:
  - 通用编程
date: 2020-03-12 23:41:46
updated: 2020-03-12 23:41:46
icon:
sticky:
type:
url:
description:
---

<!-- more -->

## 1.修改 user 获得 root 的放权



## 2.关闭防火墙服务并禁用启动项

CentOS 6 root

```
su root exit
sudo service iptables status
sudo service iptables stop
sudo chkconfig iptables off
```



查看所有启动项   可用提示功能

```
chkconfig --list
```



查看所有服务

```
service --status-all
```

##  

## 3.设置IP

### 修改本机ip 符合 NAT 网段

1.修改文件

2.使用图形设置

```
IP Address    NAT 设置 IP 起始往后

NetMask       NAT 同
Gateway       NAT 中     NAT 设置中     网关 IP
DNS           8.8.8.8    223.6.6.6
```



## 4.修改 HOST 主机名

```
sudo vim /etc/sysconfig/network
```

更改HOSTNAME   重启后生效



## 5.配置 Host 文件

```
sudo vim /etc/hosts
```

添加自身在内的所有节点host及对应ip



## 6.配置公私钥

```
cd ~/.ssh/

# 添加密钥
ssh-keygen -t rsa    
```



远程终端上

```
# 公钥复制到远程终端并写入
cat id_rsa.pub >> authorized_keys   
chmod 600 authorized_keys
chmod 700 ~/.ssh
SSH HOSTNAME或IP即可
```



## 7.JDK复制并配置 $PATH

```
# 复制并定位到用户目录桌面下
cd ~/desktop
mkdir java
mv ~/Desktop/A.tar ./java/

tar zxvf A.tar
vim ~/.bashrc     

# 设置 PATH 加入
export JAVA_HOME=/home/USERNAME/BIN/jdk
export PATH=${JAVA_HOME}/bin:$PATH

# 生效
source ~/.bashrc     

echo $PATH
```



## 8.Hadoop复制并配置$PATH

```
# 复制到目录 并 解压
vim ~/.bashrc    

# 设置 PATH 加入
export HADOOP_HOME=/home/USERNAME/BIN/hadoop
export PATH=${HADOOP_HOME}/bin:${HADOOP_HOME}/sbin:$PATH

# 生效
source ~/.bashrc
```



## 9.修改Hadoop相关配置文件

```
# 配置文件路径
*/hadoop/etc/hadoop/

# 修改文件
hadoop-env.sh  #25

# 修改JAVA_HOME目录
yarn-env.sh   #
yarn-site.xml
core-site.xml
hdfs-site.xml
mapred-site.xml
```



## 10.分步启动 伪分布式 主节点Hadoop

格式化文件系统

```
hadoop namemode -format
```



启动HDFS的命令 datanode

```
start-dfs.sh
```



启动yarn

```
start-yarn.sh
```



验证启动

```
jsp
​    namenode
​    datanode
​    secondaryNameNode
​    ResouceManger
```



单独启动/停止某一个进程 如 namenode、yarn的进程

```
hadoop-daemon.sh start namenode
```



## 11.配置分布式 从节点 Hadoop

关机 并复制主节点 

```
halt
```



修改 HOST 主机名

```
sudo vim /etc/sysconfig/network
```



删掉node2 公私钥 创建新密钥

```
cd ~/.ssh
rm id_rsa.pub
rm authorized_keys
ssh-keygen -t rsa [path]
```



修改authorized_keys

在node2 的 authorized_keys 添加 node1公钥

复制 公钥和的 authorized_keys 到 node1

相反亦可



并测试SSH

```
cat ./id_dsa.pub >> ~/.ssh/authorized_keys
scp root@A0:/home/a/.ssh/id_dsa.pub ./id-dsa.pub.A0
cat id-dsa.pub.A0 >> authorized_keys
scp ./authorized_keys root@A0:/home/a/.ssh/authorized_keys

ssh A0
exit
ssh A1
exit
```

