---
title: SSH远程登录
---
为交换机和无线控制器开启SSH服务端功能，用户名和密码为admin，密码为明文类型,特权密码为admin

```
no password policy strong
no password policy min-size 
no password policy forced-password-modify

no service password-encryption

no enable secret
enable password 0 admin

username admin privilege 1 password 0 admin
username admin login mode ssh

enable service ssh-server
line vty 0 4
login local
transport input ssh
exit
```
