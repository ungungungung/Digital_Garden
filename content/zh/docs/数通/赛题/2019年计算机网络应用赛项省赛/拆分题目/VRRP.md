---
title: VRRP
---
在广州校区交换机S1、S2、S3、S4上配置MSTP防止二层环路；要求所有有线数据流经过S4转发，S4失效时经过S3转发。所有无线数据流经过S3转发，S3失效时经过S4转发。所配置的参数要求如下：
-  region-name为ruijie；
-  revision版本为1；
-  S3作为实例1中的主根， S4作为实例2中的主根；
-  主根优先级为4096，从根优先级为8192；
-  在S3和S4上配置VRRP，实现主机的网关冗余，所配置的参数要求如表1-11；
-  S3、S4各VRRP组中高优先级设置为150，低优先级设置为120。

| VLAN          | VRRP备份组号（VRID） | VRRP虚拟IP       |
| ------------- | -------------- | -------------- |
| VLAN10        | 10             | 192.XX.10.254  |
| VLAN20        | 20             | 192.XX.20.254  |
| VLAN30        | 30             | 192.XX.30.254  |
| VLAN50        | 50             | 192.XX.50.254  |
| VLAN60        | 60             | 192.XX.60.254  |
| VLAN70        | 70             | 192.XX.70.254  |
| VLAN100(交换机间) | 100            | 192.XX.100.254 |

```
# S3
interface vlan 10
vrrp 10 ip 192.1.10.254
vrrp 10 priority 120
exit
interface vlan 20
vrrp 20 ip 192.1.20.254
vrrp 20 priority 120
exit
interface vlan 30
vrrp 30 ip 192.1.30.254
vrrp 30 priority 120
exit
interface vlan 100
vrrp 100 ip 192.1.100.254
vrrp 100 priority 120
exit

interface vlan 50
vrrp 50 ip 192.1.50.254
vrrp 50 priority 150
exit
interface vlan 60
vrrp 60 ip 192.1.60.254
vrrp 60 priority 150
exit
interface vlan 70
vrrp 70 ip 192.1.70.254
vrrp 70 priority 150
exit

# S4
interface vlan 10
vrrp 10 ip 192.1.10.254
vrrp 10 priority 150
exit
interface vlan 20
vrrp 20 ip 192.1.20.254
vrrp 20 priority 150
exit
interface vlan 30
vrrp 30 ip 192.1.30.254
vrrp 30 priority 150
exit
interface vlan 100
vrrp 100 ip 192.1.100.254
vrrp 100 priority 150
exit


interface vlan 50
vrrp 50 ip 192.1.50.254
vrrp 50 priority 120
exit
interface vlan 60
vrrp 60 ip 192.1.60.254
vrrp 60 priority 120
exit
interface vlan 70
vrrp 70 ip 192.1.70.254
vrrp 70 priority 120
exit

```

#### 显示命令
`show vrrp brief`
