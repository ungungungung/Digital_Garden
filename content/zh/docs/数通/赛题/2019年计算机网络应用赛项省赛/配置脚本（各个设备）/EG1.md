---
title: EG1
---

```
# 设备命名
hostname GZXQ-EG2000-01

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
ip address 10.1.0.30 30
exit
interface gigabitEthernet 0/4
ip address 20.1.0.1 28
exit
interface loopback 0
ip address 11.1.0.11 32
exit

# 配置默认路由和静态路由
ip route 193.1.0.0 255.255.0.0 20.1.0.2
ip route 192.1.0.0 255.255.0.0 10.1.0.29
# ip route 172.16.0.0 255.255.240.0 10.1.0.29

ip route 10.1.0.0 255.255.255.0 10.1.0.29
ip route 11.1.0.0 255.255.255.0 10.1.0.29

# 配置 NAT 的 ACL 110
ip access-list extended 110
deny ip 192.1.10.0 0.0.0.255 193.1.20.0 0.0.0.255
deny ip 192.1.10.0 0.0.0.255 193.1.30.0 0.0.0.255
deny ip 192.1.10.0 0.0.0.255 193.1.40.0 0.0.0.255
deny ip 192.1.20.0 0.0.0.255 193.1.20.0 0.0.0.255
deny ip 192.1.20.0 0.0.0.255 193.1.30.0 0.0.0.255
deny ip 192.1.20.0 0.0.0.255 193.1.40.0 0.0.0.255
deny ip 192.1.30.0 0.0.0.255 193.1.20.0 0.0.0.255
deny ip 192.1.30.0 0.0.0.255 193.1.30.0 0.0.0.255
deny ip 192.1.30.0 0.0.0.255 193.1.40.0 0.0.0.255
deny ip 192.1.60.0 0.0.0.255 193.1.20.0 0.0.0.255
deny ip 192.1.60.0 0.0.0.255 193.1.30.0 0.0.0.255
deny ip 192.1.60.0 0.0.0.255 193.1.40.0 0.0.0.255
deny ip 192.1.70.0 0.0.0.255 193.1.20.0 0.0.0.255
deny ip 192.1.70.0 0.0.0.255 193.1.30.0 0.0.0.255
deny ip 192.1.70.0 0.0.0.255 193.1.40.0 0.0.0.255

permit ip 192.1.10.0 0.0.0.255 any
permit ip 192.1.20.0 0.0.0.255 any
permit ip 192.1.30.0 0.0.0.255 any
permit ip 192.1.60.0 0.0.0.255 any
permit ip 192.1.70.0 0.0.0.255 any
exit

# 配置 NAT

ip nat pool interface 20.1.0.1 20.1.0.1 netmask 255.255.255.255
ip nat inside source list 110 pool interface overload

interface gigabitEthernet 0/0
ip nat inside
exit
# 如果没有g0/4，需要启动并修改成WAN接口
interface gigabitEthernet 0/4
ip nat outside
exit

# 配置全局流表策略部署 (疑问)

ip access-list extended 102
permit icmp any host 20.1.0.1
permit tcp any host 20.1.0.1 eq telnet
permit ip 192.10.0.0 0.0.0.255 any
permit ip 192.20.0.0 0.0.0.255 any
permit ip 192.30.0.0 0.0.0.255 any
permit ip 192.50.0.0 0.0.0.255 any
permit ip 192.60.0.0 0.0.0.255 any
permit ip 192.70.0.0 0.0.0.255 any
permit esp any any
exit
ip session filter 102

# 配置 IPSecVPN 的 ACL

ip access-list extended 101
permit ip 192.1.10.0 0.0.0.255 193.1.20.0 0.0.0.255
permit ip 192.1.10.0 0.0.0.255 193.1.30.0 0.0.0.255
permit ip 192.1.10.0 0.0.0.255 193.1.40.0 0.0.0.255
permit ip 192.1.20.0 0.0.0.255 193.1.20.0 0.0.0.255
permit ip 192.1.20.0 0.0.0.255 193.1.30.0 0.0.0.255
permit ip 192.1.20.0 0.0.0.255 193.1.40.0 0.0.0.255
permit ip 192.1.30.0 0.0.0.255 193.1.20.0 0.0.0.255
permit ip 192.1.30.0 0.0.0.255 193.1.30.0 0.0.0.255
permit ip 192.1.30.0 0.0.0.255 193.1.40.0 0.0.0.255
permit ip 192.1.60.0 0.0.0.255 193.1.20.0 0.0.0.255
permit ip 192.1.60.0 0.0.0.255 193.1.30.0 0.0.0.255
permit ip 192.1.60.0 0.0.0.255 193.1.40.0 0.0.0.255
permit ip 192.1.70.0 0.0.0.255 193.1.20.0 0.0.0.255
permit ip 192.1.70.0 0.0.0.255 193.1.30.0 0.0.0.255
permit ip 192.1.70.0 0.0.0.255 193.1.40.0 0.0.0.255
exit

# 配置 IPSecVPN

crypto isakmp policy 10
encryption 3des
authentication pre-share
hash md5
group 2
exit

crypto isakmp key 0 123456 address 20.1.0.2

crypto ipsec transform-set tran1 esp-3des esp-md5-hmac
exit

crypto map mymap 10 ipsec-isakmp
set peer 20.1.0.2
set isakmp-policy 10
set transform-set tran1
match address 101
exit

interface gigabitEthernet 0/4
crypto map mymap
exit

```
