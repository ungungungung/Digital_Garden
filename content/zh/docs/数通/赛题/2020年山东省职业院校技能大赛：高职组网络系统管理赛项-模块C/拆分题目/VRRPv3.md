---
title: VRRPv3
---
8.IPv6 部署
-  S3、S4 启用 IPV6 网络，实现 IPV6 终端可自动从网关处获取地址。地址
规划如下：

| device | interface | IPv6 address         | VRID | Virtual IP           |
| :----: | --------- | -------------------- | ---- | -------------------- |
|   S3   | VLAN10    | 2001:192:10::252/64  | 10   | 2001:192:10::254/64  |
|        | VLAN20    | 2001:192:20::252/64  | 20   | 2001:192:20::254/64  |
|        | VLAN30    | 2001:192:30::252/64  | 30   | 2001:192:30::254/64  |
|        | VLAN40    | 2001:192:40::252/64  | 40   | 2001:192:40::254/64  |
|        | VLAN60    | 2001:192:60::252/64  | 60   | 2001:192:60::254/64  |
|        | VLAN100   | 2001:192:100::252/64 | 100  | 2001:192:100::254/64 |
|   S4   | VLAN10    | 2001:192:10::253/64  | 10   | 2001:192:10::254/64  |
|        | VLAN20    | 2001:192:20::253/64  | 20   | 2001:192:20::254/64  |
|        | VLAN30    | 2001:192:30::253/64  | 30   | 2001:192:30::254/64  |
|        | VLAN40    | 2001:192:40::253/64  | 40   | 2001:192:40::254/64  |
|        | VLAN60    | 2001:192:60::253/64  | 60   | 2001:192:60::254/64  |
|        | VLAN100   | 2001:192:100::253/64 | 100  | 2001:192:100::254/64 |

-  在 S3 和S4 上配置 VRRP for IPv6，实现主机的 IPv6 网关冗余；
-  VRRP 主备状态与 IPV4 网络一致；

```
# S3
interface vlan 10
ipv6 enable
ipv6 address 2001:192:10::252/64
vrrp ipv6 10 priority 200
vrrp 10 ipv6 fe80::
vrrp 10 ipv6 2001:192:10::254
vrrp ipv6 10 accept_mode
no ipv6 nd suppress-ra
ipv6 nd managed-config-flag
ipv6 nd other-config-flag
exit
interface vlan 20
ipv6 enable
ipv6 address 2001:192:20::252/64
vrrp ipv6 20 priority 200
vrrp 20 ipv6 fe80::
vrrp 20 ipv6 2001:192:20::254
vrrp ipv6 20 accept_mode
no ipv6 nd suppress-ra
ipv6 nd managed-config-flag
ipv6 nd other-config-flag
exit
interface vlan 30
ipv6 enable
ipv6 address 2001:192:30::252/64
vrrp ipv6 30 priority 200
vrrp 30 ipv6 fe80::
vrrp 30 ipv6 2001:192:30::254
vrrp ipv6 30 accept_mode
no ipv6 nd suppress-ra
ipv6 nd managed-config-flag
ipv6 nd other-config-flag
exit
interface vlan 40
ipv6 enable
ipv6 address 2001:192:40::252/64
vrrp ipv6 40 priority 200
vrrp 40 ipv6 fe80::
vrrp 40 ipv6 2001:192:40::254
vrrp ipv6 40 accept_mode
no ipv6 nd suppress-ra
ipv6 nd managed-config-flag
ipv6 nd other-config-flag
exit
interface vlan 60
ipv6 enable
ipv6 address 2001:192:60::252/64
vrrp ipv6 60 priority 110
vrrp 60 ipv6 fe80::
vrrp 60 ipv6 2001:192:60::254
vrrp ipv6 60 accept_mode
no ipv6 nd suppress-ra
ipv6 nd managed-config-flag
ipv6 nd other-config-flag
exit
interface vlan 100
ipv6 enable
ipv6 address 2001:192:100::252/64
vrrp ipv6 100 priority 200
vrrp 100 ipv6 fe80::
vrrp 100 ipv6 2001:192:100::254
vrrp ipv6 100 accept_mode
no ipv6 nd suppress-ra
ipv6 nd managed-config-flag
ipv6 nd other-config-flag
exit

```

```
# S4
interface vlan 10
ipv6 enable
ipv6 address 2001:192:10::253/64
vrrp ipv6 10 priority 110
vrrp 10 ipv6 fe80::
vrrp 10 ipv6 2001:192:10::254
vrrp ipv6 10 accept_mode
no ipv6 nd suppress-ra
ipv6 nd managed-config-flag
ipv6 nd other-config-flag
exit
interface vlan 20
ipv6 enable
ipv6 address 2001:192:20::253/64
vrrp ipv6 20 priority 110
vrrp 20 ipv6 fe80::
vrrp 20 ipv6 2001:192:20::254
vrrp ipv6 20 accept_mode
no ipv6 nd suppress-ra
ipv6 nd managed-config-flag
ipv6 nd other-config-flag
exit
interface vlan 30
ipv6 enable
ipv6 address 2001:192:30::253/64
vrrp ipv6 30 priority 110
vrrp 30 ipv6 fe80::
vrrp 30 ipv6 2001:192:30::254
vrrp ipv6 30 accept_mode
no ipv6 nd suppress-ra
ipv6 nd managed-config-flag
ipv6 nd other-config-flag
exit
interface vlan 40
ipv6 enable
ipv6 address 2001:192:40::253/64
vrrp ipv6 40 priority 110
vrrp 40 ipv6 fe80::
vrrp 40 ipv6 2001:192:40::254
vrrp ipv6 40 accept_mode
no ipv6 nd suppress-ra
ipv6 nd managed-config-flag
ipv6 nd other-config-flag
exit
interface vlan 60
ipv6 enable
ipv6 address 2001:192:60::253/64
vrrp ipv6 60 priority 200
vrrp 60 ipv6 fe80::
vrrp 60 ipv6 2001:192:60::254
vrrp ipv6 60 accept_mode
no ipv6 nd suppress-ra
ipv6 nd managed-config-flag
ipv6 nd other-config-flag
exit
interface vlan 100
ipv6 enable
ipv6 address 2001:192:100::253/64
vrrp ipv6 100 priority 110
vrrp 100 ipv6 fe80::
vrrp 100 ipv6 2001:192:100::254
vrrp ipv6 100 accept_mode
no ipv6 nd suppress-ra
ipv6 nd managed-config-flag
ipv6 nd other-config-flag
exit

```