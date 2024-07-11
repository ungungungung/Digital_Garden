---
title: VPN部署
---
5.VPN 部署
-  为了实现总部与办事处互访数据的安全性，同时要求总部对办事处路由器采用本地的用户名、密码方式进行验证，为此规划如下：
-  部署 L2TP 隧道进行总部对办事处路由的对接验证，验证用户名密码均ruijie，L2TP 隧道密码为 ruijie;
-  L2TP 用户地址池为 10.1.2.1—10.1.2.254;
-  L2TP 隧道中承载OSPF 协议，使其总部与办事处通过 OSPF 进行路由交互，区域号 1；
-  部署 IPsec 对L2TP 隧道中的业务数据加密；
-  IPsec VPN 需要采用传输模式，预共享密码为 ruijie，加密认证方式为ESP-3DES、ESP-MD5-HMAC，DH 使用组 2；

EG2的LAN口转换为WAN口

```
# L2TP 隧道中承载OSPF 协议，使其总部与办事处通过 OSPF 进行路由交互，区域号 1

# EG1
router ospf 30
network 10.1.2.0 0.0.0.255 area 0
exit

# EG2
router ospf 10
network 10.1.2.0 0.0.0.255 area 0
exit

```