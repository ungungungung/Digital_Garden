---
title: MSTP
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
# vlan50、60、70 是实例1 (无线)
# vlan10、20、30、100 是实例2 (有线)

# S1
spanning-tree
spanning-tree mode mstp
spanning-tree mst configuration
instance 1 vlan 50,60,70
instance 2 vlan 10,20,30,100
revision 1
name ruijie
exit

# S2
spanning-tree
spanning-tree mode mstp
spanning-tree mst configuration
instance 1 vlan 50,60,70
instance 2 vlan 10,20,30,100
revision 1
name ruijie
exit

# S3
spanning-tree
spanning-tree mode mstp
spanning-tree mst configuration
instance 1 vlan 50,60,70
instance 2 vlan 10,20,30,100
revision 1
name ruijie
exit
spanning-tree mst 1 priority 4096
spanning-tree mst 2 priority 8192

# S4
spanning-tree
spanning-tree mode mstp
spanning-tree mst configuration
instance 1 vlan 50,60,70
instance 2 vlan 10,20,30,100
revision 1
name ruijie
exit
spanning-tree mst 1 priority 8192
spanning-tree mst 2 priority 4096

```

#### 显示命令
`show spanning-tree summary`