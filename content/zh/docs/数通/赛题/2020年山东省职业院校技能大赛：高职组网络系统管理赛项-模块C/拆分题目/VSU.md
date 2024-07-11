---
title: VSU
---
5.网络设备虚拟化

两台接入交换机通过 VSU 虚拟化为一台设备进行管理，从而实现高可靠性。
当任意交换机故障时，都能实现设备、链路切换，保护客户业务稳定运行。
-  规划 S1 和S2 间的 Te0/25-26 端口作为 VSL 链路，使用 VSU 技术实现网
络设备虚拟化。其中 S1 为主，S2 为备；
-  规划 S1 和 S2 间的 Gi0/17 端口作为双主机检测链路，配置基于 BFD 的双
主机检测，当 VSL 的所有物理链路都异常断开时，备机会切换成主机，
从而保障网络正常；
-  主 设 备 ： Domain id ： 1,switch id:1,priority 200,
description:S2910-24GT4XS-E-1；
-  备 设 备 ： Domain id ： 1,switch id:2,priority 150,
description:S2910-24GT4XS-E-2。

```
# S1
switch virtual domain 1
switch 1
switch 1 priority 200
switch 1 description S2910-24GT4XS-E-1
exit
vsl-port
port-member interface tenGigabitEthernet 0/25
port-member interface tenGigabitEthernet 0/26
exit
exit
switch convert mode virtual
yes

# S2
switch virtual domain 1
switch 2
switch 2 priority 150
switch 2 description S2910-24GT4XS-E-2
exit
vsl-port
port-member interface tenGigabitEthernet 0/25
port-member interface tenGigabitEthernet 0/26
exit
exit
switch convert mode virtual
yes

# S1等待重启后
interface gigabitEthernet 1/0/17
no switchport
exit
interface gigabitEthernet 2/0/17
no switchport
exit
switch virtual domain 1
dual-active detection bfd
dual-active bfd interface gigabitEthernet 1/0/17
dual-active bfd interface gigabitEthernet 2/0/17
exit

```

##### 其他命令
`show switch virtual dual-active ?/bfd`
`show switch virtual ?/config`
`switch crc errors 10 times 20`
`switch convert mode ?`
