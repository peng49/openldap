# openldap

使用docker启动一个debian的容器

> docker run -it -d -p 389:389 --name ldap-server --restart always --hostname ldap.fly-develop.com debian:stable-slim

进入容器

> docker exec -it ldap-server bash

安装 openldap和ldap工具包

> apt update && apt -y install slapd ldap-utils vim net-tools

查看保存的数据
> slapcat

```
root@ldap:/# slapcat 
dn: dc=fly-develop,dc=com
objectClass: top
objectClass: dcObject
objectClass: organization
o: fly-develop.com
dc: fly-develop
structuralObjectClass: organization
entryUUID: 1aca965c-a272-103b-8907-b55aac8557aa
creatorsName: cn=admin,dc=fly-develop,dc=com
createTimestamp: 20210905085046Z
entryCSN: 20210905085046.038378Z#000000#000#000000
modifiersName: cn=admin,dc=fly-develop,dc=com
modifyTimestamp: 20210905085046Z
```

启动服务
> service slapd start



