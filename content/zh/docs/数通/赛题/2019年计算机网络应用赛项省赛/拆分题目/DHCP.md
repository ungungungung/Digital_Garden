---
title: DHCP
---
在交换机S3、S4上配置DHCP中继，对VLAN10内的用户进行中继，使得本部PC1用户使用DHCP Relay方式获取IP地址。具体要求如下：
-  DHCP服务器搭建于R2上，地址池命名为Pool_VLAN10，DHCP对外服务使用loopback 0地址；
-  为了防御动态环境局域网伪DHCP服务欺骗，在S2交换机部署DHCP Snooping功能；
-  为了防止大量网关发送的正常的相关报文被接入交换机误认为是攻击被丢弃，从而导致下联用户无法获取网关的ARP信息而无法上网，要求关闭S2上联口的NFPP功能的ARP检测；
-  全局设置NFPP日志缓存容量为1024，打印相同log的阈值为300s;
-  调整CPU保护机制阈值为500pps；
-  为了防止伪 IP 源地址攻击， 导致出口路由器会话占满，要求S2交换机部署端口安全，接口Gi0/9只允许PC2通过。

```
# R2

service dhcp
ip dhcp pool Pool_VLAN10
network 192.1.10.0 255.255.255.0
default-route 192.1.10.254
exit

```

```
# S3

service dhcp
interface vlan 10
ip helper-address 11.1.0.2
exit

```

```
# S4

service dhcp
interface vlan 10
ip helper-address 11.1.0.2
exit

```