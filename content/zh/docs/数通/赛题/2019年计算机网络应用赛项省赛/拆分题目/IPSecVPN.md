---
title: IPSecVPN
---
为了实现广州校区与福州校区互访数据的安全性，要求使用IPSec对广州校区到福州校区的数据流进行加密。为此规划如下：
要求使用静态隧道主模式，安全协议采用esp协议，加密算法采用3des，认证算法采用md5，以IKE方式建立IPsec SA。
在 EG1和EG2上所配置的参数要求如下：（123gitu123b）
-  ACL编号为101；
-  静态的ipsec加密图mymap；
-  预共享密钥为明文123456；

```
# EG1

ip access-list extended 101
permit ip 192.1.10.0 0.0.0.255 193.1.20.0 0.0.0.255
permit ip 192.1.10.0 0.0.0.255 193.1.30.0 0.0.0.255
permit ip 192.1.10.0 0.0.0.255 193.1.40.0 0.0.0.255
permit ip 192.1.20.0 0.0.0.255 193.1.20.0 0.0.0.255
permit ip 192.1.20.0 0.0.0.255 193.1.30.0 0.0.0.255
permit ip 192.1.20.0 0.0.0.255 193.1.40.0 0.0.0.255
permit ip 192.1.30.0 0.0.0.255 193.1.20.0 0.0.0.255
permit ip 192.1.30.0 0.0.0.255 193.1.30.0 0.0.0.255
permit ip 192.1.30.0 0.0.0.255 193.1.40.0 0.0.0.255
permit ip 192.1.60.0 0.0.0.255 193.1.20.0 0.0.0.255
permit ip 192.1.60.0 0.0.0.255 193.1.30.0 0.0.0.255
permit ip 192.1.60.0 0.0.0.255 193.1.40.0 0.0.0.255
permit ip 192.1.70.0 0.0.0.255 193.1.20.0 0.0.0.255
permit ip 192.1.70.0 0.0.0.255 193.1.30.0 0.0.0.255
permit ip 192.1.70.0 0.0.0.255 193.1.40.0 0.0.0.255
exit

crypto isakmp policy 10
encryption 3des
authentication pre-share
hash md5
group 2
exit

crypto isakmp key 0 123456 address 20.1.0.2

crypto ipsec transform-set tran1 esp-3des esp-md5-hmac
exit

crypto map mymap 10 ipsec-isakmp
set peer 20.1.0.2
set isakmp-policy 10
set transform-set tran1
match address 101
exit

interface gigabitEthernet 0/4
crypto map mymap
exit

```

```
# EG2

ip access-list extended 101
permit ip 193.1.20.0 0.0.0.255 192.1.10.0 0.0.0.255
permit ip 193.1.20.0 0.0.0.255 192.1.20.0 0.0.0.255
permit ip 193.1.20.0 0.0.0.255 192.1.30.0 0.0.0.255
permit ip 193.1.20.0 0.0.0.255 192.1.60.0 0.0.0.255
permit ip 193.1.20.0 0.0.0.255 192.1.70.0 0.0.0.255
permit ip 193.1.30.0 0.0.0.255 192.1.10.0 0.0.0.255
permit ip 193.1.30.0 0.0.0.255 192.1.20.0 0.0.0.255
permit ip 193.1.30.0 0.0.0.255 192.1.30.0 0.0.0.255
permit ip 193.1.30.0 0.0.0.255 192.1.60.0 0.0.0.255
permit ip 193.1.30.0 0.0.0.255 192.1.70.0 0.0.0.255
permit ip 193.1.40.0 0.0.0.255 192.1.10.0 0.0.0.255
permit ip 193.1.40.0 0.0.0.255 192.1.20.0 0.0.0.255
permit ip 193.1.40.0 0.0.0.255 192.1.30.0 0.0.0.255
permit ip 193.1.40.0 0.0.0.255 192.1.60.0 0.0.0.255
permit ip 193.1.40.0 0.0.0.255 192.1.70.0 0.0.0.255
exit

crypto isakmp policy 10
encryption 3des
authentication pre-share
hash md5
group 2
exit

crypto isakmp key 0 123456 address 20.1.0.1

crypto ipsec transform-set tran1 esp-3des esp-md5-hmac
exit

crypto map mymap 10 ipsec-isakmp
set peer 20.1.0.1
set isakmp-policy 10
set transform-set tran1
match address 101
exit

interface gigabitEthernet 0/4
crypto map mymap
exit

```

##### 显示
`show crypto isakmp policy`
