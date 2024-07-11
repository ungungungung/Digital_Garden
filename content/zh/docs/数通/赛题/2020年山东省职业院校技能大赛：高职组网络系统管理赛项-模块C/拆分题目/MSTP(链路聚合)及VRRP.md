---
title: MSTP(链路聚合)及VRRP
---
4.MSTP 及VRRP 部署

在交换机 S3、S4 上配置 MSTP 防止二层环路。要求 VLAN10、VLAN20、VLAN30、VLAN40、VLAN100 数据流经过 S3 转发，VLAN50、VLAN60 数据流经过 S4 转发，S3、S4 其中一台宕机时均可无缝切换至另一台进行转发。所配置的参数要求如下：
-  region-name 为ruijie；
-  revision 版本为 1；
-  实例 1，包含 VLAN10、VLAN20、VLAN30、VLAN40、VLAN100；
-  实例 2，包含 VLAN50,VLAN60；
-  S3 作为实例 0、1 中的主根，S4 作为实例 0、1 的从根；
-  S4 作为实例 2 中的主根，S3 作为实例 2 的从根；
-  主根优先级为 4096，从根优先级为 8192；
-  在 S3 和 S4 上配置 VRRP，实现主机的网关冗余。所配置的参数要求如表
4；
-  S3、S4 各VRRP 组中高优先级设置为 200，低优先级设置为 110。

| VLAN | VRID |   Virtual IP    |
| :--: | :--: | :-------------: |
|  10  |  10  | 192.168.10.254  |
|  20  |  20  | 192.168.20.254  |
|  30  |  30  | 192.168.30.254  |
|  40  |  40  | 192.168.40.254  |
|  50  |  50  | 192.168.50.254  |
|  60  |  60  | 192.168.60.254  |
| 100  | 100  | 192.168.100.254 |

```
# S3

# 创建VLAN
vlan range 10,20,30,40,50,60,100,101
exit

# VLAN命名
vlan 10
name Office10
exit
vlan 20
name Office20
exit
vlan 30
name Office30
exit
vlan 40
name Office40
exit
vlan 50
name AP
exit
vlan 60
name Wireless
exit
vlan 100
name Manage
exit
vlan 101
name Connect
exit

# 链路聚合
interface range gigabitEthernet 0/2-3
port-group 1
exit

# trunk
interface gigabitEthernet 0/1
switchport mode trunk
switchport trunk allowed vlan only 10,20,30,40,50,60,100
exit
interface aggregatePort 1
switchport mode trunk
switchport trunk allowed vlan only 10,20,30,40,50,60,100,101
exit

# IP
interface vlan 10
ip address 192.1.10.252 255.255.255.0
exit
interface vlan 20
ip address 192.1.20.252 255.255.255.0
exit
interface vlan 30
ip address 192.1.30.252 255.255.255.0
exit
interface vlan 40
ip address 192.1.40.252 255.255.255.0
exit
interface vlan 50
ip address 192.1.50.252 255.255.255.0
exit
interface vlan 60
ip address 192.1.60.252 255.255.255.0
exit
interface vlan 100
ip address 192.1.100.252 255.255.255.0
exit
interface vlan 101
ip address 10.1.0.53 255.255.255.252
exit

interface gigabitEthernet 0/4
no switchport
ip address 10.1.0.5 255.255.255.252
exit
interface gigabitEthernet 0/5
no switchport
ip address 10.1.0.9 255.255.255.252
exit
interface loopback 0
ip address 11.1.0.33 255.255.255.255
exit

# MSTP
spanning-tree
spanning-tree mode mstp
spanning-tree mst configuration
instance 1 vlan 10,20,30,40,100
instance 2 vlan 50,60
revision 1
name ruijie
exit
spanning-tree mst 0 priority 4096
spanning-tree mst 1 priority 4096
spanning-tree mst 2 priority 8192

# VRRP
interface vlan 10
vrrp 10 ip 192.1.10.254
vrrp 10 priority 200
exit
interface vlan 20
vrrp 20 ip 192.1.20.254
vrrp 20 priority 200
exit
interface vlan 30
vrrp 30 ip 192.1.30.254
vrrp 30 priority 200
exit
interface vlan 40
vrrp 40 ip 192.1.40.254
vrrp 40 priority 200
exit
interface vlan 50
vrrp 50 ip 192.1.50.254
vrrp 50 priority 110
exit
interface vlan 60
vrrp 60 ip 192.1.60.254
vrrp 60 priority 110
exit
interface vlan 100
vrrp 100 ip 192.1.100.254
vrrp 100 priority 200
exit

```

```
# S4

# 创建VLAN
vlan range 10,20,30,40,50,60,100,101
exit

# VLAN命名
vlan 10
name Office10
exit
vlan 20
name Office20
exit
vlan 30
name Office30
exit
vlan 40
name Office40
exit
vlan 50
name AP
exit
vlan 60
name Wireless
exit
vlan 100
name Manage
exit
vlan 101
name Connect
exit

# 链路聚合
interface range gigabitEthernet 0/2-3
port-group 1
exit

# trunk
interface gigabitEthernet 0/1
switchport mode trunk
switchport trunk allowed vlan only 10,20,30,40,50,60,100
exit
interface aggregatePort 1
switchport mode trunk
switchport trunk allowed vlan only 10,20,30,40,50,60,100,101
exit
interface gigabitEthernet 0/6
switchport mode trunk
switchport trunk native vlan 100
switchport trunk allowed vlan only 100
exit

# IP
interface vlan 10
ip address 192.1.10.253 255.255.255.0
exit
interface vlan 20
ip address 192.1.20.253 255.255.255.0
exit
interface vlan 30
ip address 192.1.30.253 255.255.255.0
exit
interface vlan 40
ip address 192.1.40.253 255.255.255.0
exit
interface vlan 50
ip address 192.1.50.253 255.255.255.0
exit
interface vlan 60
ip address 192.1.60.253 255.255.255.0
exit
interface vlan 100
ip address 192.1.100.253 255.255.255.0
exit
interface vlan 101
ip address 10.1.0.54 255.255.255.252
exit

interface gigabitEthernet 0/4
no switchport
ip address 10.1.0.13 255.255.255.252
exit
interface gigabitEthernet 0/5
no switchport
ip address 10.1.0.17 255.255.255.252
exit
interface loopback 0
ip address 11.1.0.34 255.255.255.255
exit

# MSTP
spanning-tree
spanning-tree mode mstp
spanning-tree mst configuration
instance 1 vlan 10,20,30,40,100
instance 2 vlan 50,60
revision 1
name ruijie
exit
spanning-tree mst 0 priority 8192
spanning-tree mst 1 priority 8192
spanning-tree mst 2 priority 4096

# VRRP
interface vlan 10
vrrp 10 ip 192.1.10.254
vrrp 10 priority 110
exit
interface vlan 20
vrrp 20 ip 192.1.20.254
vrrp 20 priority 110
exit
interface vlan 30
vrrp 30 ip 192.1.30.254
vrrp 30 priority 110
exit
interface vlan 40
vrrp 40 ip 192.1.40.254
vrrp 40 priority 110
exit
interface vlan 50
vrrp 50 ip 192.1.50.254
vrrp 50 priority 200
exit
interface vlan 60
vrrp 60 ip 192.1.60.254
vrrp 60 priority 200
exit
interface vlan 100
vrrp 100 ip 192.1.100.254
vrrp 100 priority 110
exit

```

```
# VSU(S1、S2)

# 创建VLAN
vlan range 10,20,30,40,50,60,100
exit

# trunk
interface gigabitEthernet 1/0/24
switchport mode trunk
switchport trunk allowed vlan only 10,20,30,40,50,60,100
exit
interface gigabitEthernet 2/0/24
switchport mode trunk
switchport trunk allowed vlan only 10,20,30,40,50,60,100
exit
interface range gigabitEthernet 1/0/21-22
switchport mode trunk
switchport trunk allowed vlan only 50,60
switchport trunk native vlan 50
exit
interface range gigabitEthernet 2/0/21-22
switchport mode trunk
switchport trunk allowed vlan only 50,60
switchport trunk native vlan 50
exit

# access
interface range gigabitEthernet 1/0/1-4
switchport mode access
switchport access vlan 10
exit
interface range gigabitEthernet 2/0/1-4
switchport mode access
switchport access vlan 10
exit
interface range gigabitEthernet 1/0/5-8
switchport mode access
switchport access vlan 20
exit
interface range gigabitEthernet 2/0/5-8
switchport mode access
switchport access vlan 20
exit
interface range gigabitEthernet 1/0/9-12
switchport mode access
switchport access vlan 30
exit
interface range gigabitEthernet 2/0/9-12
switchport mode access
switchport access vlan 30
exit
interface range gigabitEthernet 1/0/13-16
switchport mode access
switchport access vlan 40
exit
interface range gigabitEthernet 2/0/13-16
switchport mode access
switchport access vlan 40
exit

# MSTP
spanning-tree
spanning-tree mode mstp
spanning-tree mst configuration
instance 1 vlan 10,20,30,40,100
instance 2 vlan 50,60
revision 1
name ruijie
exit

# 配置IP
interface vlan 100
ip address 192.1.100.12 255.255.255.0
exit

```
