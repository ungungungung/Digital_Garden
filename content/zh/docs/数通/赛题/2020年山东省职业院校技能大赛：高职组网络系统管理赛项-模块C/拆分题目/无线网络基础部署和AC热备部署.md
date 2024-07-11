---
title: 无线网络基础部署和AC热备部署
---
1.无线网络基础部署
-  使用 S3、S4 为无线用户与 AP DHCP 服务器，S3 分配地址范围为其网段的1至100，S4 分配地址为其网段的 101 至200（使用最短的命令实现）。使用 AC1 为办事处无线用户与 AP DHCP 服务器；
-  创建 SSID (WLAN-ID 1)为 Ruijie-ZB_XX(XX 现场提供)，AP-Group 为ZB，本部无线用户关联 SSID 后可自动获取地址；
-  创建 SSID (WLAN-ID 2)为 Ruijie-BSC_XX(XX 现场提供)，AP-Group 为BSC，办事处无线用户关联 SSID 后可自动获取地址；
2.AC 热备部署
-  为了减轻 AC1 的负担，因此 AC2 为主用 AC，AC1 为备用 AC；
-  AP 与 AC1、AC2 均建立隧道，当 AP 与主用 AC 失去连接时能无缝切换至备用 AC 并提供服务。

```
# 使用 S3、S4 为无线用户与 AP DHCP 服务器，S3 分配地址范围为其网段的1至100，S4 分配地址为其网段的 101 至200（使用最短的命令实现）

# S3
service dhcp

ip dhcp pool vlan50
network 192.1.50.0 255.255.255.0
default-router 192.1.50.254
option 138 ip 11.1.0.205 11.1.0.204
exit
ip dhcp pool vlan60
network 192.1.60.0 255.255.255.0
default-router 192.1.60.254
exit

ip dhcp excluded-address 192.1.60.101 192.1.60.254
ip dhcp excluded-address 192.1.70.101 192.1.70.254

# S4
service dhcp

ip dhcp pool vlan50
network 192.1.50.0 255.255.255.0
default-router 192.1.50.254
option 138 ip 11.1.0.205 11.1.0.204
exit
ip dhcp pool vlan60
network 192.1.60.0 255.255.255.0
default-router 192.1.60.254
exit

ip dhcp excluded-address 192.1.60.1 192.1.60.100
ip dhcp excluded-address 192.1.70.1 192.1.70.100
ip dhcp excluded-address 192.1.60.201 192.1.60.254
ip dhcp excluded-address 192.1.70.201 192.1.70.254

```

```
# 使用 AC1 为办事处无线用户与 AP DHCP 服务器

# AC1
service dhcp

ip dhcp pool vlan20
network 195.1.20.0 255.255.255.0
default-router 195.1.20.254
exit
ip dhcp pool vlan30
network 195.1.30.0 255.255.255.0
default-router 195.1.30.254
option 138 ip 11.1.0.205 11.1.0.204
exit

```

```
# 创建 SSID (WLAN-ID 1)为 Ruijie-ZB_XX(XX 现场提供)，AP-Group 为ZB，本部无线用户关联 SSID 后可自动获取地址
# 创建 SSID (WLAN-ID 2)为 Ruijie-BSC_XX(XX 现场提供)，AP-Group 为BSC，办事处无线用户关联 SSID 后可自动获取地址

# AC1
ac-controller
capwap ctrl-ip 11.1.0.204
exit

ap-group BSC
exit
ap-group ZB
exit

# AP3上线后, 加入BSC组
ap-config xxxx.xxxx.xxxx
ap-name BSC-AP850-01
ap-group BSC
exit

# AP1上线后，加入ZB组
ap-config xxxx.xxxx.xxxx
ap-name ZB-AP520-01
ap-group ZB
exit
# AP2上线后，加入ZB组
ap-config xxxx.xxxx.xxxx
ap-name ZB-AP520-02
ap-group ZB
exit

wlan-config 1 Ruijie-ZB_1
exit
wlan-config 2 Ruijie-BSC_1
exit

ap-group ZB
interface-mapping 1 60 ap-wlan-id 1
exit
ap-group BSC
interface-mapping 2 20 ap-wlan-id 2
exit

# AC2
ac-controller
capwap ctrl-ip 11.1.0.205
exit

ap-group BSC
exit
ap-group ZB
exit

# AP3上线后, 加入BSC组
ap-config xxxx.xxxx.xxxx
ap-name BSC-AP850-01
ap-group BSC
exit

# AP1上线后，加入ZB组
ap-config xxxx.xxxx.xxxx
ap-name ZB-AP520-01
ap-group ZB
exit
# AP2上线后，加入ZB组
ap-config xxxx.xxxx.xxxx
ap-name ZB-AP520-02
ap-group ZB
exit

wlan-config 1 Ruijie-ZB_1
exit
wlan-config 2 Ruijie-BSC_1
exit

ap-group ZB
interface-mapping 1 60 ap-wlan-id 1
exit
ap-group BSC
interface-mapping 2 20 ap-wlan-id 2
exit

```

```
# 为了减轻 AC1 的负担，因此 AC2 为主用 AC，AC1 为备用 AC
# AP 与 AC1、AC2 均建立隧道，当 AP 与主用 AC 失去连接时能无缝切换至备用 AC 并提供服务

# AC1
wlan hot-backup 11.1.0.205
context 10
priority level 4
ap-group ZB
ap-group BSC
exit
wlan hot-backup enable
exit

# AP3上线后, 加入BSC组
ap-config xxxx.xxxx.xxxx
ap-name BSC-AP850-01
ap-group BSC
exit

# AP1上线后，加入ZB组
ap-config xxxx.xxxx.xxxx
ap-name ZB-AP520-01
ap-group ZB
exit
# AP2上线后，加入ZB组
ap-config xxxx.xxxx.xxxx
ap-name ZB-AP520-02
ap-group ZB
exit

# AC2
wlan hot-backup 11.1.0.204
context 10
priority level 7
ap-group ZB
ap-group BSC
exit
wlan hot-backup enable
exit

# AP3上线后, 加入BSC组
ap-config xxxx.xxxx.xxxx
ap-name BSC-AP850-01
ap-group BSC
exit

# AP1上线后，加入ZB组
ap-config xxxx.xxxx.xxxx
ap-name ZB-AP520-01
ap-group ZB
exit
# AP2上线后，加入ZB组
ap-config xxxx.xxxx.xxxx
ap-name ZB-AP520-02
ap-group ZB
exit

```