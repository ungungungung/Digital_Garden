---
title: VAC
---
### 实验环境

```
设备
	AC1
	AC2

连接情况
	AC1_G0/1 <--> AC_G0/1
	AC1_G0/2 <--> AC_G0/2
	AC1_G0/3 <--> AC_G0/3

```

### 实验要求

```
1、AC1和AC2虚拟化为一台AC

2、VAC的心跳链路为AC1和AC2的G0/1、G0/2

3、配置基于BFD的双主机链路检测，BFD链路为AC1和AC2的G0/3

```

### 实验步骤

```
# AC1

hostname AC1

virtual-ac domain 100
device 1
device 1 priority 200
exit

vac-port
port-member interface GigabitEthernet 0/1
port-member interface GigabitEthernet 0/2
exit

exit
device convert mode virtual
y
y

```

```
# AC2

hostname AC2

virtual-ac domain 100
device 2
device 2 priority 100
exit

vac-port
port-member interface GigabitEthernet 0/1
port-member interface GigabitEthernet 0/2
exit

exit
device convert mode virtual
y
y

```

```
# AC1 (等待两个设备重启后)

interface gigabitEthernet 1/0/3
no switchport
exit
interface gigabitEthernet 2/0/3
no switchport
exit

virtual-ac domain 100
dual-active detection bfd
dual-active bfd interface gigabitEthernet 1/0/3
dual-active bfd interface gigabitEthernet 2/0/3
exit

```

```
# 查看命令
show virtual-ac ?
show virtual-ac link
show virtual-ac config
show virtual-ac topology
show virtual-ac dual-active summary
show virtual-ac dual-active bfd

```
