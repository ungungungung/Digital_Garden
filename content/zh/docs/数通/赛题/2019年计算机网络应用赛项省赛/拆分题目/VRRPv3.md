---
title: VRRPv3
---
-  广州校区部署IPV6网络实现内网IPV6终端通过无状态自动从网关处获取地址；
-  在S3、S4上配置VRRP for IPv6，实现主机的IPv6网关冗余;
-  VRRP与MSTP的主备状态与IPV4网络一致；IPV6地址规划如下：

| 设备  |   接口    |        IPv6地址        | VRRP组号 |         虚拟IP         |  虚拟链路本地地址  |
| :-: | :-----: | :------------------: | :----: | :------------------: | :--------: |
| S3  | VLAN10  | 2001:192:10::252/64  |   10   | 2001:192:10::254/64  | FE80::4/64 |
|     | VLAN20  | 2001:192:20::252/64  |   20   | 2001:192:20::254/64  | FE80::4/64 |
|     | VLAN30  | 2001:192:30::252/64  |   30   | 2001:192:30::254/64  | FE80::4/64 |
|     | VLAN50  | 2001:192:50::252/64  |   50   | 2001:192:50::254/64  | FE80::4/64 |
|     | VLAN60  | 2001:192:60::252/64  |   60   | 2001:192:60::254/64  | FE80::4/64 |
|     | VLAN70  | 2001:192:70::252/64  |   70   | 2001:192:70::254/64  | FE80::4/64 |
|     | VLAN100 | 2001:192:100::252/64 |  100   | 2001:192:100::254/64 | FE80::4/64 |
| S4  | VLAN10  | 2001:192:10::253/64  |   10   | 2001:192:10::254/64  | FE80::4/64 |
|     | VLAN20  | 2001:192:20::253/64  |   20   | 2001:192:20::254/64  | FE80::4/64 |
|     | VLAN30  | 2001:192:30::253/64  |   30   | 2001:192:30::254/64  | FE80::4/64 |
|     | VLAN50  | 2001:192:50::253/64  |   50   | 2001:192:50::254/64  | FE80::4/64 |
|     | VLAN60  | 2001:192:60::253/64  |   60   | 2001:192:60::254/64  | FE80::4/64 |
|     | VLAN70  | 2001:192:70::253/64  |   70   | 2001:192:70::254/64  | FE80::4/64 |
|     | VLAN100 | 2001:192:100::253/64 |  100   | 2001:192:100::254/64 | FE80::4/64 |

```
# S3

interface vlan 10
vrrp ipv6 10 priority 120
ipv6 address 2001:192:10::252/64
vrrp 10 ipv6 fe80::4
vrrp 10 ipv6 2001:192:10::254
no ipv6 nd suppress-ra
exit

interface vlan 20
ipv6 enable
ipv6 address 2001:192:20::252/64
vrrp ipv6 20 priority 120
vrrp 20 ipv6 fe80::4
vrrp 20 ipv6 2001:192:20::254
no ipv6 nd suppress-ra
exit

interface vlan 30
ipv6 enable
ipv6 address 2001:192:30::252/64
vrrp ipv6 30 priority 120
vrrp 30 ipv6 fe80::4
vrrp 30 ipv6 2001:192:30::254
no ipv6 nd suppress-ra
exit

interface vlan 50
ipv6 enable
ipv6 address 2001:192:50::252/64
vrrp ipv6 50 priority 150
vrrp 50 ipv6 fe80::4
vrrp 50 ipv6 2001:192:50::254
no ipv6 nd suppress-ra
exit

interface vlan 60
ipv6 enable
ipv6 address 2001:192:60::252/64
vrrp ipv6 60 priority 150
vrrp 60 ipv6 fe80::4
vrrp 60 ipv6 2001:192:60::254
no ipv6 nd suppress-ra
exit

interface vlan 70
ipv6 enable
ipv6 address 2001:192:70::252/64
vrrp ipv6 70 priority 150
vrrp 70 ipv6 fe80::4
vrrp 70 ipv6 2001:192:70::254
no ipv6 nd suppress-ra
exit

interface vlan 100
ipv6 enable
ipv6 address 2001:192:100::252/64
vrrp ipv6 100 priority 120
vrrp 100 ipv6 fe80::4
vrrp 100 ipv6 2001:192:100::254
no ipv6 nd suppress-ra
exit

```

```
# S4

interface vlan 10
vrrp ipv6 10 priority 150
ipv6 address 2001:192:10::253/64
vrrp 10 ipv6 fe80::4
vrrp 10 ipv6 2001:192:10::254
no ipv6 nd suppress-ra
exit

interface vlan 20
ipv6 enable
ipv6 address 2001:192:20::253/64
vrrp ipv6 20 priority 150
vrrp 20 ipv6 fe80::4
vrrp 20 ipv6 2001:192:20::254
no ipv6 nd suppress-ra
exit

interface vlan 30
ipv6 enable
ipv6 address 2001:192:30::253/64
vrrp ipv6 30 priority 150
vrrp 30 ipv6 fe80::4
vrrp 30 ipv6 2001:192:30::254
no ipv6 nd suppress-ra
exit

interface vlan 50
ipv6 enable
ipv6 address 2001:192:50::253/64
vrrp ipv6 50 priority 120
vrrp 50 ipv6 fe80::4
vrrp 50 ipv6 2001:192:50::254
no ipv6 nd suppress-ra
exit

interface vlan 60
ipv6 enable
ipv6 address 2001:192:60::253/64
vrrp ipv6 60 priority 120
vrrp 60 ipv6 fe80::4
vrrp 60 ipv6 2001:192:60::254
no ipv6 nd suppress-ra
exit

interface vlan 70
ipv6 enable
ipv6 address 2001:192:70::253/64
vrrp ipv6 70 priority 120
vrrp 70 ipv6 fe80::4
vrrp 70 ipv6 2001:192:70::254
no ipv6 nd suppress-ra
exit

interface vlan 100
ipv6 enable
ipv6 address 2001:192:100::253/64
vrrp ipv6 100 priority 150
vrrp 100 ipv6 fe80::4
vrrp 100 ipv6 2001:192:100::254
no ipv6 nd suppress-ra
exit
```