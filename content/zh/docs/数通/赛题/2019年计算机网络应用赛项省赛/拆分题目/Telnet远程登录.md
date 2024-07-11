---
title: Telnet远程登录
---
为路由器和出口网关开启Telnet功能，对所有Telnet用户采用本地认证的方式。创建本地用户，设定用户名和密码为admin，密码为明文类型,特权密码为admin

```
no password policy strong
no password policy min-size

no service password-encryption

no enable secret
enable password 0 admin

username admin privilege 1 password 0 admin
username admin login mode telnet

enable service telnet-server
line vty 0 4
login local
transport input telnet
exit
```