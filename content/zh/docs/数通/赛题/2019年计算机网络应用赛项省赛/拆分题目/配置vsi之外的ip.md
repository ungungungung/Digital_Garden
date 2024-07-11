---
title: 配置vsi之外的ip
---
```
# AC1
hostname AC1
interface loopback 0
ip address 11.1.0.21 32
exit
interface gigabitEthernet 0/1
no switchport
ip address 10.1.0.9 30
exit

```

```
# AC2
hostname AC2
interface loopback 0
ip address 11.1.0.22 32
exit
interface gigabitEthernet 0/1
no switchport
ip address 10.1.0.13 30
exit

```

```
# R1
hostname R1
interface loopback 0
ip address 11.1.0.1 255.255.255.255
exit
interface gigabitEthernet 0/0
ip address 10.1.0.10 255.255.255.252
exit
interface gigabitEthernet 0/1
ip address 10.1.0.14 255.255.255.252
exit
interface serial 2/0
encapsulation ppp
ip address 10.1.0.17 255.255.255.252
exit
interface serial 2/1
encapsulation ppp
ip address 10.1.0.21 255.255.255.252
exit

```

```
# R2
hostname R2
interface loopback 0
ip address 11.1.0.2 255.255.255.255
exit
interface gigabitEthernet 0/0
ip address 10.1.0.2 255.255.255.252
exit
interface gigabitEthernet 0/1
ip address 10.1.0.6 255.255.255.252
exit
interface serial 2/0
encapsulation ppp
ip address 10.1.0.18 255.255.255.252
exit
interface serial 2/1
encapsulation ppp
ip address 10.1.0.25 255.255.255.252
exit

```

```
# R3
hostname R3
interface loopback 0
ip address 11.1.0.3 255.255.255.255
exit
interface gigabitEthernet 0/0
ip address 10.1.0.29 255.255.255.252
exit
interface serial 2/0
encapsulation ppp
ip address 10.1.0.26 255.255.255.252
exit
interface serial 2/1
encapsulation ppp
ip address 10.1.0.22 255.255.255.252
exit
```

```
# EG1
hostname EG1
interface loopback 0
ip address 11.1.0.11 32
exit
interface gigabitEthernet 0/0
ip address 10.1.0.30 30
exit
interface gigabitEthernet 0/4
ip address 20.1.0.1 28
exit

```
