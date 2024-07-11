---
title: AC热备（负载均衡）
---
### 实验环境

```
设备
    AC1
    AC2
    AP1
    AP2
    SW1

网段
    AC1 和 AC2 (vlan100: 192.168.100.0/24)
    AP1 和 AP2 (vlan200: 192.168.200.0/24)
    user1 (vlan10: 192.168.10.0/24)
    user2 (vlan20: 192.168.20.0/24)

wifi
    ssid1: user1 (wpa2: p0-p0-p0-)
    ssid2: user2

连接情况
    AC1 --> S1-G0/1
    AC2 --> S1-G0/2
    AP1 --> S1-G0/3
    AP2 --> S1-G0/4
    
```

### 实验要求

```
热备负载均衡
    wifi user1 的主设备是AC1, 从设备是AC2, AP组为ap1(AP1)
    wifi user2 的主设备是AC2, 从设备是AC1, AP组为ap2(AP2)
```

### 实验步骤

```
# S1

hostname S1

vlan 100
name AC
exit
vlan 200
name AP
exit
vlan 10
name user1
exit
vlan 20
name user2
exit

interface vlan 100
ip address 192.168.100.254 24
exit
interface vlan 200
ip address 192.168.200.254 24
exit
interface vlan 10
ip address 192.168.10.254 24
exit
interface vlan 20
ip address 192.168.20.254 24
exit

interface gigabitEthernet 0/1
switchport access vlan 100
exit
interface gigabitEthernet 0/2
switchport access vlan 100
exit
interface gigabitEthernet 0/3
switchport mode trunk 
switchport trunk allowed vlan only 200,10,20
switchport trunk native vlan 200
exit
interface gigabitEthernet 0/4
switchport mode trunk 
switchport trunk allowed vlan only 200,10,20
switchport trunk native vlan 200
exit

service dhcp
ip dhcp pool ap
option 138 ip 1.1.1.1 2.2.2.2
network 192.168.200.0 255.255.255.0
default-route 192.168.200.254
exit
ip dhcp pool user1
network 192.168.10.0 255.255.255.0
default-route 192.168.10.254
exit
ip dhcp pool user2
network 192.168.20.0 255.255.255.0
default-route 192.168.20.254
exit

ip route 1.1.1.1 255.255.255.255 192.168.100.1
ip route 2.2.2.2 255.255.255.255 192.168.100.2

```

```
# AC1

hostname AC1

interface vlan 1
ip address 192.168.100.1 24
exit
interface loopback 0
ip address 1.1.1.1 32
exit

ip route 0.0.0.0 0.0.0.0 192.168.100.254

ac-controller
capwap ctrl-ip 1.1.1.1
exit

ap-group ap1
exit

ap-group ap2
exit

wlan hot-backup 2.2.2.2
context 10
priority level 7
ap-group ap1
exit
context 20
ap-group ap2
exit
wlan hot-backup enable
exit

# AP1上线后, 加入ap1组
ap-config xxxx.xxxx.xxxx
ap-group ap1
exit

# AP2上线后, 加入ap2组
ap-config xxxx.xxxx.xxxx
ap-group ap2
exit

wlan-config 1 user1
tunnel local
exit
wlan-config 2 user2
tunnel local
exit

ap-group ap1
interface-mapping 1 10 ap-wlan-id 1
exit

ap-group ap2
interface-mapping 2 20 ap-wlan-id 2
exit

wlansec 1
security rsn enable
security rsn ciphers aes enable
security rsn akm psk enable
security rsn akm psk set-key ascii p0-p0-p0-
exit

```

```
# AC2

hostname AC2

interface vlan 1
ip address 192.168.100.2 24
exit
interface loopback 0
ip address 2.2.2.2 32
exit

ip route 0.0.0.0 0.0.0.0 192.168.100.254

ac-controller
capwap ctrl-ip 2.2.2.2
exit

ap-group ap1
exit

ap-group ap2
exit

wlan hot-backup 1.1.1.1
context 10
ap-group ap1
exit
context 20
priority level 7
ap-group ap2
exit
wlan hot-backup enable
exit

# AP1上线后, 加入ap1组
ap-config xxxx.xxxx.xxxx
ap-group ap1
exit

# AP2上线后, 加入ap2组
ap-config xxxx.xxxx.xxxx
ap-group ap2
exit

wlan-config 1 user1
tunnel local
exit
wlan-config 2 user2
tunnel local
exit

ap-group ap1
interface-mapping 1 10 ap-wlan-id 1
exit

ap-group ap2
interface-mapping 2 20 ap-wlan-id 2
exit

wlansec 1
security rsn enable
security rsn ciphers aes enable
security rsn akm psk enable
security rsn akm psk set-key ascii p0-p0-p0-
exit

```
