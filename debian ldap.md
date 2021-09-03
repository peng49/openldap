[在debian上安装和配置openldap](https://computingforgeeks.com/how-to-install-and-configure-openldap-server-on-debian/)

## 安装

安装openldap和ldap操作工具包

> apt install -y slapd ldap-utils 

安装slapd时会要求输入密码，输入后记住即可

## 配置
修改  /etc/ldap/ldap.conf
```
#
# LDAP Defaults
#

# See ldap.conf(5) for details
# This file should be world readable but not world writable.

BASE   dc=fly-develop,dc=com
#URI    ldap://ldap.example.com ldap://ldap-master.example.com:666

#SIZELIMIT      12
#TIMELIMIT      15
#DEREF          never

# TLS certificates (needed for GnuTLS)
TLS_CACERT      /etc/ssl/certs/ca-certificates.crt
```

重新加载配置文件

> dpkg-reconfigure slapd

查看所有数据
> slapcat


添加基础域名
```
vim fly-develop.ldif

# 添加如下内容(注意每行的结尾不能有空格,否则会报错)

dn: dc=fly-develop,dc=com
objectclass: dcObject
objectclass: organization
o: orgName
dc: fly-develop
```

> ldapadd -x -D dc=fly-develop,dc=com -W -f fly-develop.ldif


## 启动



## 操作

