---
title: NAT
---
出口网关及出口路由器上进行NAT配置实现广州校区与福州校区的所有用户(ACL 110)均可访问互联网，通过NAPT方式将内网用户IP地址转换到互联网接口上；

```
# EG1

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

ip nat pool interface 20.1.0.1 20.1.0.1 netmask 255.255.255.240
ip nat inside source list 110 pool interface overload

interface gigabitEthernet 0/0
ip nat inside
exit

specify interface GigabitEthernet 0/4 wan
exit
write
reload
y

# 等待重启后配置
interface gigabitEthernet 0/4
ip nat outside
exit

```

```
# EG2

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

ip nat pool interface 20.1.0.2 20.1.0.2 netmask 255.255.255.240
ip nat inside source list 110 pool interface overload

interface gigabitEthernet 0/0
ip nat inside
exit

interface gigabitEthernet 0/1
ip nat inside
exit

specify interface GigabitEthernet 0/4 wan
exit
write
reload
y

# 等待重启后配置
interface gigabitEthernet 0/4
ip nat outside
exit

```