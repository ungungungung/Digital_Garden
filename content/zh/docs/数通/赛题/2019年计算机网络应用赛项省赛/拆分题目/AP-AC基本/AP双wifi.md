---
title: AP双wifi
---
### 实验环境

```
AC和两台AP直连
AP的vlan为10
user1的vlan为20
user2的vlan为30
AC通过DHCP的option138下发AC地址
vlan10、vlan20、vlan30均通过DHCP分配地址

实验的结果就是两个AP发射user1和user2的wifi
```

### 实验要求

```
ssid: user1
ssid: user2
option138下发AC地址
```

### 命令

```
hostname AC

vlan 10
name ap
exit
vlan 20
name user1
exit
vlan 30
name user2
exit

interface vlan 10
ip address 192.168.10.254 24
exit
interface vlan 20
ip address 192.168.20.254 24
exit
interface vlan 30
ip address 192.168.30.254 24
exit
interface loopback 0
ip address 1.1.1.1 32
exit

service dhcp
ip dhcp pool ap
option 138 ip 1.1.1.1
network 192.168.10.0 255.255.255.0
default-route 192.168.10.254
exit
ip dhcp pool user1
network 192.168.20.0 255.255.255.0
default-route 192.168.20.254
exit
ip dhcp pool user2
network 192.168.30.0 255.255.255.0
default-route 192.168.30.254
exit

interface gigabitEthernet 0/1
switchport mode trunk
switchport trunk native vlan 10
switchport trunk allowed vlan only 10,20,30
exit
interface gigabitEthernet 0/2
switchport mode trunk
switchport trunk native vlan 10
switchport trunk allowed vlan only 10,20,30
exit

wlan-config 1 user1
tunnel local
exit
wlan-config 2 user2
tunnel local
exit

ap-group two_ap
interface-mapping 1 20 ap-wlan-id 1
interface-mapping 2 30 ap-wlan-id 2
exit

# ap上线后，更改ap名称
ap-config xxxx.xxxx.xxxx
ap-name ap1
ap-group two_ap
exit

ap-config xxxx.xxxx.xxxx
ap-name ap2
ap-group two_ap
exit

```