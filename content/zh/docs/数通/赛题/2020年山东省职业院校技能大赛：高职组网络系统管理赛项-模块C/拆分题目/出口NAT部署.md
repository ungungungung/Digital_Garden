---
title: 出口NAT部署
---
1.出口NAT 部署
-  总部出口网关上配置访问控制列表 ACL 120，仅允许用户在周一到周五的上班时间（命名为 work，9:00 至 17:00）通过 NAPT 访问互联网，NAPT映射到互联网接口上，服务器上网不受限制;
-  办事处出口网关上配置访问控制列表 ACL120，允许用户通过 NAPT 访问互联网，NAPT 映射到互联网接口上；
-  办事处网关上配置端口映射，使 AC1（11.1.0.204）设备的 SSH 服务可以通过互联网被访问，映射地址为 197.1.0.5:2222。

```
# 总部出口网关上配置访问控制列表 ACL 120，仅允许用户在周一到周五的上班时间（命名为 work，9:00 至 17:00）通过 NAPT 访问互联网，NAPT映射到互联网接口上，服务器上网不受限制

# EG2
time-range work
periodic weekdays 09:00 to 17:00
exit
ip access-list extended 120
permit ip 192.1.10.0 0.0.0.255 any time-range work
permit ip 192.1.20.0 0.0.0.255 any time-range work
permit ip 192.1.30.0 0.0.0.255 any time-range work
permit ip 192.1.40.0 0.0.0.255 any time-range work
permit ip 192.1.60.0 0.0.0.255 any time-range work
permit ip 172.17.0.0 0.0.0.255 any time-range work
permit ip 172.16.0.0 0.0.0.255 any
exit

ip nat inside source list 120 interface GigabitEthernet 0/2 overload

interface GigabitEthernet 0/0
ip nat inside
exit
interface GigabitEthernet 0/1
ip nat inside
exit
interface GigabitEthernet 0/2
ip nat outside
exit

```

```
# 办事处出口网关上配置访问控制列表 ACL120，允许用户通过 NAPT 访问互联网，NAPT 映射到互联网接口上
# 办事处网关上配置端口映射，使 AC1（11.1.0.204）设备的 SSH 服务可以通过互联网被访问，映射地址为 197.1.0.5:2222

# EG1
ip access-list extended 120
permit ip 195.1.10.0 0.0.0.255 any
permit ip 195.1.20.0 0.0.0.255 any
exit

ip nat inside source list 120 interface GigabitEthernet 0/2 overload

interface GigabitEthernet 0/0
ip nat inside
exit
interface GigabitEthernet 0/2
ip nat outside
exit

ip nat inside source static tcp 11.1.0.204 22 197.1.0.5 2222

```
