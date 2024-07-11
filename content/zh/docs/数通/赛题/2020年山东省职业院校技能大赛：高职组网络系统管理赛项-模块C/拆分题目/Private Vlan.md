---
title: Private Vlan
---
为节省 IP 资源，隔离广播风暴、病毒攻击，控制端口二层互访，在 S7交换机使用 Private Vlan

```
# S7
vlan 10
name Primary
exit
vlan 11
name Community
exit
vlan 12
name Isolated
exit

vlan 11
private-vlan community 
exit
vlan 12
private-vlan isolated
exit
vlan 10
private-vlan primary
private-vlan association 11,12
exit

interface range gigabitEthernet 0/1-8
switchport mode private-vlan host
switchport private-vlan host-association 10 11
exit

interface range gigabitEthernet 0/9-16
switchport mode private-vlan host
switchport private-vlan host-association 10 12
exit

interface vlan 10
ip address 194.1.10.254 255.255.255.0
exit

```
