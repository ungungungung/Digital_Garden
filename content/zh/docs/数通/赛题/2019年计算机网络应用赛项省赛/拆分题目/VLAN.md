---
title: VLAN
---
### S1
```
# 创建VLAN和配置VLAN接口地址

enable
configure terminal
hostname S1

vlan range 50,100
exit

vlan 50
name AP
exit
vlan 60
name Teacher
exit
vlan 70
name student
exit
vlan 100
name Manage
exit

interface VLAN 100
ip address 192.1.100.1 24
exit

# access和trunk

interface range gigabitEthernet 0/1 - 3
switchport mode trunk
switchport trunk allowed vlan only 50,60,70,100
switchport trunk native vlan 50
exit

interface range gigabitEthernet 0/23 - 24
switchport mode trunk
switchport trunk allowed vlan only 50,60,70,100
exit

```

### S2
```
# 创建VLAN和配置VLAN接口地址

enable
configure terminal
hostname S2

vlan range 10,20,30,100
exit

vlan 10
name Jiaoxue
exit
vlan 20
name Sushe
exit
vlan 30
name Tushu
exit
vlan 100
name Manage
exit

interface VLAN 100
ip address 192.1.100.2 24
exit

# access和trunk

interface range gigabitEthernet 0/1 - 4
switchport mode access
switchport access vlan 10
exit
interface range gigabitEthernet 0/5 - 8
switchport mode access
switchport access vlan 20
exit
interface range gigabitEthernet 0/9 - 11
switchport mode access
switchport access vlan 30
exit

interface range gigabitEthernet 0/23 - 24
switchport mode trunk
switchport trunk allowed vlan only 10,20,30,100
exit

```

### S3
```
# 创建VLAN和配置VLAN接口地址

enable
configure terminal
hostname S3

vlan range 10,20,30,50,60,70,100
exit

vlan 10
name Jiaoxue
exit
vlan 20
name Sushe
exit
vlan 30
name Tushu
exit
vlan 50
name AP
exit
vlan 60
name Teacher
exit
vlan 70
name student
exit
vlan 100
name Manage
exit

interface VLAN 10
ip address 192.1.10.252 24
exit
interface VLAN 20
ip address 192.1.20.252 24
exit
interface VLAN 30
ip address 192.1.30.252 24
exit
interface VLAN 50
ip address 192.1.50.252 24
exit
interface VLAN 60
ip address 192.1.60.252 24
exit
interface VLAN 70
ip address 192.1.70.252 24
exit
interface VLAN 100
ip address 192.1.100.252 24
exit
interface gigabitEthernet 0/24
no switchport
ip address 10.1.0.1 30
exit
interface loopback 0
ip address 11.1.0.33 32
exit

# access和trunk

interface range gigabitEthernet 0/3 - 4
port-group 1
exit

interface aggregatePort 1
switchport mode trunk
switchport trunk allowed vlan only 10,20,30,50,60,70,100
exit

interface range gigabitEthernet 0/1
switchport mode trunk
switchport trunk allowed vlan only 50,60,70,100
exit

interface range gigabitEthernet 0/2
switchport mode trunk
switchport trunk allowed vlan only 10,20,30,100
exit

```

### S4
```
# 创建VLAN和配置VLAN接口地址

enable
configure terminal
hostname S4

vlan range 10,20,30,50,60,70,100
exit

vlan 10
name Jiaoxue
exit
vlan 20
name Sushe
exit
vlan 30
name Tushu
exit
vlan 50
name AP
exit
vlan 60
name Teacher
exit
vlan 70
name student
exit
vlan 100
name Manage
exit

interface VLAN 10
ip address 192.1.10.253 24
exit
interface VLAN 20
ip address 192.1.20.253 24
exit
interface VLAN 30
ip address 192.1.30.253 24
exit
interface VLAN 50
ip address 192.1.50.253 24
exit
interface VLAN 60
ip address 192.1.60.253 24
exit
interface VLAN 70
ip address 192.1.70.253 24
exit
interface VLAN 100
ip address 192.1.100.253 24
exit
interface gigabitEthernet 0/24
no switchport
ip address 10.1.0.5 30
exit
interface loopback 0
ip address 11.1.0.34 32
exit

# access和trunk

interface range gigabitEthernet 0/3 - 4
port-group 1
exit

interface aggregatePort 1
switchport mode trunk
switchport trunk allowed vlan only 10,20,30,50,60,70,100
exit

interface range gigabitEthernet 0/1
switchport mode trunk
switchport trunk allowed vlan only 50,60,70,100
exit

interface range gigabitEthernet 0/2
switchport mode trunk
switchport trunk allowed vlan only 10,20,30,100
exit

```
