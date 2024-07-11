---
title: OSPF
---
广州校区与福州校区内网均使用OSPF协议组网，各校区访问互联网均使用默认路由。具体要求如下：
-  广州校区R1、R2、R3、AC1、AC2、S3、S4间运行OSPF，进程号为10，规划多区域（R1、R2、R3区域0，R1、AC1、AC2区域1，R2、S3、S4区域2）；
-  广州校区EG1使用静态路由；
-  福州校区EG2、S6/S7间运行OSPF，进程号为10； 
-  广州校区区域1为完全NSSA区域； 
-  要求业务网段中不出现协议报文；
-  要求所有路由协议都发布具体网段；
-  为了管理方便，需要发布Loopback地址;
-  优化OSPF相关配置，以尽量加快OSPF收敛；
-  福州校区需要重分发默认路由到OSPF中；
-  广州校区出口路由器R3上配置默认路由，并需要让广州校区所有设备都学习到指向R3的默认路由；
-  重发布路由进OSPF中使用类型1。
注意：(S5需要重发布云平台（172.16.0.0/22）静态路由至福州校区)

```
# R1
router ospf 10
network 10.1.0.16 0.0.0.3 area 0
network 10.1.0.20 0.0.0.3 area 0
network 11.1.0.1 0.0.0.0 area 0
network 10.1.0.8 0.0.0.3 area 1
network 10.1.0.12 0.0.0.3 area 1
area 1 nssa no-summary 
exit

```

```
# R2
router ospf 10
network 10.1.0.16 0.0.0.3 area 0
network 10.1.0.24 0.0.0.3 area 0
network 11.1.0.2 0.0.0.0 area 0
network 10.1.0.0 0.0.0.3 area 2
network 10.1.0.4 0.0.0.3 area 2
exit

```

```
# R3

ip route 0.0.0.0 0.0.0.0 10.1.0.30

router ospf 10
default-information originate metric-type 1
network 10.1.0.24 0.0.0.3 area 0
network 10.1.0.20 0.0.0.3 area 0
network 11.1.0.3 0.0.0.0 area 0
exit

```

```
# AC1
router ospf 10
network 10.1.0.8 0.0.0.3 area 1
network 11.1.0.21 0.0.0.0 area 1
area 1 nssa no-summary 
exit

```

```
# AC2
router ospf 10
network 10.1.0.12 0.0.0.3 area 1
network 11.1.0.22 0.0.0.0 area 1
area 1 nssa no-summary 
exit

```

```
# S3
router ospf 10

passive-interface vlan 10
passive-interface vlan 20
passive-interface vlan 30
passive-interface vlan 50
passive-interface vlan 60
passive-interface vlan 70

network 11.1.0.33 0.0.0.0 area 2
network 10.1.0.0 0.0.0.3 area 2
network 192.1.10.0 0.0.0.255 area 2
network 192.1.20.0 0.0.0.255 area 2
network 192.1.30.0 0.0.0.255 area 2
network 192.1.50.0 0.0.0.255 area 2
network 192.1.60.0 0.0.0.255 area 2
network 192.1.70.0 0.0.0.255 area 2
network 192.1.100.0 0.0.0.255 area 2
exit

```

```
# S4
router ospf 10

passive-interface vlan 10
passive-interface vlan 20
passive-interface vlan 30
passive-interface vlan 50
passive-interface vlan 60
passive-interface vlan 70

network 11.1.0.34 0.0.0.0 area 2
network 10.1.0.4 0.0.0.3 area 2
network 192.1.10.0 0.0.0.255 area 2
network 192.1.20.0 0.0.0.255 area 2
network 192.1.30.0 0.0.0.255 area 2
network 192.1.50.0 0.0.0.255 area 2
network 192.1.60.0 0.0.0.255 area 2
network 192.1.70.0 0.0.0.255 area 2
network 192.1.100.0 0.0.0.255 area 2
exit

```

```
# EG1

ip route 0.0.0.0 0.0.0.0 20.1.0.2
ip route 192.1.0.0 255.255.0.0 10.1.0.29
ip route 10.1.0.0 255.255.255.0 10.1.0.29
ip route 11.1.0.0 255.255.255.0 10.1.0.29

```

福州校区EG2、S6/S7间运行OSPF，进程号为10； 
福州校区需要重分发默认路由到OSPF中；
重发布路由进OSPF中使用类型1。

```
# EG2

ip route 0.0.0.0 0.0.0.0 20.1.0.1

router ospf 10

default-information originate metric-type 1

network 11.1.0.12 0.0.0.0 area 0
network 10.1.0.32 0.0.0.3 area 0
network 10.1.0.36 0.0.0.255 area 0
network 193.1.30.0 0.0.0.255 area 0
exit

```

```
# VSU

router ospf 10

passive-interface vlan 10
passive-interface vlan 20
passive-interface vlan 30
passive-interface vlan 40

network 11.1.0.12 0.0.0.0 area 0
network 10.1.0.32 0.0.0.3 area 0
network 10.1.0.36 0.0.0.3 area 0
network 193.1.0.0 0.0.0.3 area 0
network 193.1.20.0 0.0.0.255 area 0
network 193.1.30.0 0.0.0.255 area 0
network 193.1.40.0 0.0.0.255 area 0
network 193.1.100.0 0.0.0.255 area 0
exit

```

```
# S5

router ospf 10

redistribute static subnets metric-type 1

network 193.1.100.0 0.0.0.255 area 0
network 11.1.0.35 0.0.0.0 area 0
exit
```
#### 查看
`show ip ospf neighbor `
