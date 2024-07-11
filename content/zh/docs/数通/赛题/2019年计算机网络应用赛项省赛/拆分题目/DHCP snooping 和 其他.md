---
title: DHCP snooping 和 其他
---
-  为了防御动态环境局域网伪DHCP服务欺骗，在S2交换机部署DHCP Snooping功能；
-  为了防止大量网关发送的正常的相关报文被接入交换机误认为是攻击被丢弃，从而导致下联用户无法获取网关的ARP信息而无法上网，要求关闭S2上联口的NFPP功能的ARP检测；
-  全局设置NFPP日志缓存容量为1024，打印相同log的阈值为300s;
-  调整CPU保护机制阈值为500pps；
为了防止伪 IP 源地址攻击， 导致出口路由器会话占满，要求S2交换机部署端口安全，接口Gi0/9只允许PC2通过。

```
# S2

ip dhcp snooping

interface range gigabitEthernet 0/23 - 24
ip dhcp snooping trust
#ip arp inspection trust
no nfpp arp-guard enable
exit

nfpp
log-buffer entries 1024
log-buffer logs 1 interval 300
exit

cpu-protect cpu bandwidth 500

interface gigabitEthernet 0/9
switchport port-security
switchport port-security maximum 1
switchport port-security mac-address e0d4.64e0.bcad
exit

```

##### 查看
`show cpu-protect cpu`
`show nfpp log summary`
