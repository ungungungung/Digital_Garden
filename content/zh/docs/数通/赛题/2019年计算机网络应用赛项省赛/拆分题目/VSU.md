---
title: VSU
---
福州校区两台数据中心交换机通过VSU虚拟化为一台设备进行管理，从而实现高可靠性。当任意交换机故障时，都能够实现设备、链路切换，保证业务不中断。
-  规划S6和S7间的Te0/49-50端口作为VSL链路，使用VSU技术实现网络设备虚拟化。其中S6为主，S7为备；
-  规划S6和S7间的Gi0/48端口作为双主机检测链路，配置基于BFD的双主机检，当VSL的所有物理链路都异常断开时，备机会切换成主机，从而保障网络正常；
-  主设备：Domain id：1,switch id:1,priority 150, description: S6000-1;
-  备设备：Domain id：1,switch id:2,priority 120, description: S6000-2。

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

```

```
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

```

```
# S6等待重启后

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

```

##### 错误帧相关命令
`switch crc errors 10 times 20`