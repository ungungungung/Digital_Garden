---
title: SSH+Telnet+SNMP
---
2.网络设备安全技术
-  为路由器和无线控制器开启 SSH 服务端功能，用户名和密码为 admin，密码为明文类型,特权密码为 admin；
-  为交换机开启 Telnet 功能，对所有 Telnet 用户采用本地认证的方式。创建本地用户，设定用户名和密码为 admin，密码为明文类型,特权密码为 admin;
-  配置所有设备 SNMP 消息，向主机 172.16.0.254 发送 Trap 消息版本采用V2C，读写的 Community 为“ruijie”，只读的 Community 为“public”，开启 Trap 消息。

```
# 为路由器和无线控制器开启 SSH 服务端功能，用户名和密码为 admin，密码为明文类型,特权密码为 admin

# 路由器和无线控制器
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

```
# 为交换机开启 Telnet 功能，对所有 Telnet 用户采用本地认证的方式。创建本地用户，设定用户名和密码为 admin，密码为明文类型,特权密码为 admin

# 交换机
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

```
# 配置所有设备 SNMP 消息，向主机 172.16.0.254 发送 Trap 消息版本采用V2C，读写的 Community 为“ruijie”，只读的 Community 为“public”，开启 Trap 消息

# 所有设备
snmp-server host 172.16.0.254 traps version 2c ruijie
snmp-server host 172.16.0.254 traps version 2c public
snmp-server enable traps
snmp-server community ruijie rw 
snmp-server community public ro

```