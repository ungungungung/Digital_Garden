---
title: EG2
---

```
# 设备命名
hostname FZXQ-EG2000-01

# 开启接口

# 配置Telnet
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

# 配置物理地址和回环地址
interface gigabitEthernet 0/0
ip address 10.1.0.34 30
exit
interface gigabitEthernet 0/1
ip address 10.1.0.38 30
exit
interface gigabitEthernet 0/4
ip address 20.1.0.2 28
exit
interface loopback 0
ip address 11.1.0.12 32
exit

# 配置默认路由
ip route 0.0.0.0 0.0.0.0 20.1.0.1

# 配置OSPF
router ospf 10

default-information originate metric-type 1

network 11.1.0.12 0.0.0.0 area 0
network 10.1.0.32 0.0.0.3 area 0
network 10.1.0.36 0.0.0.255 area 0
network 193.1.30.0 0.0.0.255 area 0
exit

# 配置 NAT 的 ACL 110
ip access-list extended 110
deny ip 193.1.20.0 0.0.0.255 192.1.10.0 0.0.0.255
deny ip 193.1.20.0 0.0.0.255 192.1.20.0 0.0.0.255
deny ip 193.1.20.0 0.0.0.255 192.1.30.0 0.0.0.255
deny ip 193.1.20.0 0.0.0.255 192.1.60.0 0.0.0.255
deny ip 193.1.20.0 0.0.0.255 192.1.70.0 0.0.0.255
deny ip 193.1.30.0 0.0.0.255 192.1.10.0 0.0.0.255
deny ip 193.1.30.0 0.0.0.255 192.1.20.0 0.0.0.255
deny ip 193.1.30.0 0.0.0.255 192.1.30.0 0.0.0.255
deny ip 193.1.30.0 0.0.0.255 192.1.60.0 0.0.0.255
deny ip 193.1.30.0 0.0.0.255 192.1.70.0 0.0.0.255
deny ip 193.1.40.0 0.0.0.255 192.1.10.0 0.0.0.255
deny ip 193.1.40.0 0.0.0.255 192.1.20.0 0.0.0.255
deny ip 193.1.40.0 0.0.0.255 192.1.30.0 0.0.0.255
deny ip 193.1.40.0 0.0.0.255 192.1.60.0 0.0.0.255
deny ip 193.1.40.0 0.0.0.255 192.1.70.0 0.0.0.255

permit ip 193.1.20.0 0.0.0.255 any
permit ip 193.1.30.0 0.0.0.255 any
permit ip 193.1.40.0 0.0.0.255 any
exit

# 配置 NAT

ip nat pool interface 20.1.0.2 20.1.0.2 netmask 255.255.255.255
ip nat inside source list 110 pool interface overload

interface gigabitEthernet 0/0
ip nat inside
exit
interface gigabitEthernet 0/1
ip nat inside
exit
# 如果没有g0/4，需要启动并修改成WAN接口
interface gigabitEthernet 0/4
ip nat outside
exit

# 配置 IPSecVPN 的 ACL

ip access-list extended 101
permit ip 193.1.20.0 0.0.0.255 192.1.10.0 0.0.0.255
permit ip 193.1.20.0 0.0.0.255 192.1.20.0 0.0.0.255
permit ip 193.1.20.0 0.0.0.255 192.1.30.0 0.0.0.255
permit ip 193.1.20.0 0.0.0.255 192.1.60.0 0.0.0.255
permit ip 193.1.20.0 0.0.0.255 192.1.70.0 0.0.0.255
permit ip 193.1.30.0 0.0.0.255 192.1.10.0 0.0.0.255
permit ip 193.1.30.0 0.0.0.255 192.1.20.0 0.0.0.255
permit ip 193.1.30.0 0.0.0.255 192.1.30.0 0.0.0.255
permit ip 193.1.30.0 0.0.0.255 192.1.60.0 0.0.0.255
permit ip 193.1.30.0 0.0.0.255 192.1.70.0 0.0.0.255
permit ip 193.1.40.0 0.0.0.255 192.1.10.0 0.0.0.255
permit ip 193.1.40.0 0.0.0.255 192.1.20.0 0.0.0.255
permit ip 193.1.40.0 0.0.0.255 192.1.30.0 0.0.0.255
permit ip 193.1.40.0 0.0.0.255 192.1.60.0 0.0.0.255
permit ip 193.1.40.0 0.0.0.255 192.1.70.0 0.0.0.255
exit

# 配置 IPSecVPN

crypto isakmp policy 10
encryption 3des
authentication pre-share
hash md5
group 2
exit

crypto isakmp key 0 123456 address 20.1.0.1

crypto ipsec transform-set tran1 esp-3des esp-md5-hmac
exit

crypto map mymap 10 ipsec-isakmp
set peer 20.1.0.1
set isakmp-policy 10
set transform-set tran1
match address 101
exit

interface gigabitEthernet 0/4
crypto map mymap
exit

# 配置OSPF优化
interface gigabitEthernet 0/1
ip ospf network point-to-point
exit
interface gigabitEthernet 0/2
ip ospf network point-to-point
exit

```
