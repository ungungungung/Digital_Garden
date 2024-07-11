---
title: DHCP 中继与服务安全部署
---
在交换机 S3、S4 上配置 DHCP 中继，对 VLAN10 内的用户进行中继。具体要求如下：
-  DHCP 服务器搭建于 EG2 上，地址池命名为 Pool_VLAN10，DHCP 对外服务使用 loopback 0 地址；
-  为了防御动态环境局域网 ARP 欺骗及伪 DHCP 服务欺骗，在（S1/S2）上部署 DHCP Snooping+IP Source Guard+ARP-check 解决方案。
```
# DHCP 服务器搭建于 EG2 上，地址池命名为 Pool_VLAN10，DHCP 对外服务使用 loopback 0 地址

# EG2
service dhcp
ip dhcp pool Pool_VLAN10
network 192.1.10.0 255.255.255.0
default-router 192.1.10.254
exit

```

```
# 在交换机 S3、S4 上配置 DHCP 中继，对 VLAN10 内的用户进行中继。

# S3
service dhcp
interface vlan 10
ip helper-address 11.1.0.12
exit

# S4
service dhcp
interface vlan 10
ip helper-address 11.1.0.12
exit

```


```
# 为了防御动态环境局域网 ARP 欺骗及伪 DHCP 服务欺骗，在（S1/S2）上部署 DHCP Snooping+IP Source Guard+ARP-check 解决方案

# VSU(S1、S2）
ip dhcp snooping

interface gigabitEthernet 1/0/24
ip dhcp snooping trust
exit
interface gigabitEthernet 2/0/24
ip dhcp snooping trust
exit

interface range gigabitEthernet 1/0/1 - 16
ip verify source port-security
arp-check
exit
interface range gigabitEthernet 2/0/1 - 16
ip verify source port-security
arp-check
exit

```