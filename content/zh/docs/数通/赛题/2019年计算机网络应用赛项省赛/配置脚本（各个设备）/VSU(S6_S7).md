---
title: VSU(S6_S7)
---

```
# S6
switch virtual domain 1
switch 1
switch 1 priority 150
switch 1 description S6000-1
exit
vsl-port
port-member interface tenGigabitEthernet 0/49
port-member interface tenGigabitEthernet 0/50
exit
exit
switch convert mode virtual
yes

# S7
switch virtual domain 1
switch 2
switch 2 priority 120
switch 2 description S6000-2
exit
vsl-port
port-member interface tenGigabitEthernet 0/49
port-member interface tenGigabitEthernet 0/50
exit
exit
switch convert mode virtual
yes

# S6(S6和S7等待重启后)
interface gigabitEthernet 1/0/48
no switchport
exit
interface gigabitEthernet 2/0/48
no switchport
exit
switch virtual domain 1
dual-active detection bfd
dual-active bfd interface gigabitEthernet 1/0/48
dual-active bfd interface gigabitEthernet 2/0/48
exit

# 配置SSH
no password policy strong
no password policy min-size 
no password policy forced-password-modify

no service password-encryption

no enable secret
enable password 0 admin

username admin privilege 1 password 0 admin
username admin login mode ssh

enable service ssh-server
line vty 0 4
login local
transport input ssh
exit

# 配置SNMP
snmp-server host 172.16.0.254 traps version 2c ruijie
snmp-server host 172.16.0.254 traps version 2c public
snmp-server enable traps
snmp-server community ruijie rw 
snmp-server community public ro

# 配置OSPF
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

# 更改接口的OSPF开销
interface gigabitEthernet 2/0/2
ip ospf cost 10
exit

# 配置OSPF优化
interface gigabitEthernet 1/0/2
ip ospf network point-to-point
exit
interface gigabitEthernet 2/0/2
ip ospf network point-to-point
exit
interface vlan 100
ip ospf network point-to-point
exit

```
