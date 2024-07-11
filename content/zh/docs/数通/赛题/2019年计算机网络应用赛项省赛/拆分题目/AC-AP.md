---
title: AC-AP
---
1. **无线网络基础部署**
-  使用R2作为广州校区无线用户和无线AP的DHCP 服务器； 
-  创建教师内网 SSID 为 Ruijie-teacher_XX(XX现场提供)，WLAN ID 为1，AP-Group为GZ，内网无线用户关联SSID后可自动获取地址。
-  创建学生内网 SSID 为 Ruijie-student_XX(XX现场提供)，WLAN ID 为2，AP-Group为GZ，内网无线用户关联SSID后可自动获取地址。
2. **AC热备部署**
-  广州校区AC1为主用，AC2为备用。AP与AC1、AC2均建立隧道，当AP与AC1失去连接时能无缝切换至AC2并提供服务。
###### **无线安全部署**
-  教师无线用户接入无线网络时需要采用WPA2加密方式，加密密码为XX(现场提供)；
-  启用白名单校验，仅放通PC2无线终端；
- ######  无线性能优化
	-  要求内网无线网络均启用本地转发模式; 
	-  为了保障广州校区学生用户的无线体验，针对WLAN ID 2下的每个用户的下行平均速率为 800KB/s ，突发速率为1600KB/s；
	-  AP1放置于教师区，连接用户多为教师，限制AP1最大带点人数为30人；
	-  通过时间调度，要求每周一至周五的21:00至23:30期间关闭教师无线服务；
	-  设置所有AP的用户最小接入信号强度为-65dBm；
	-  关闭低速率（11b/g 1M、2M、5M，11a 6M、9M）应用接入。

```
# R2

service dhcp

ip dhcp pool vlan50
option 138 ip 11.1.0.21 11.1.0.22
network 192.1.50.0 255.255.255.0
default-route 192.1.50.254
exit

ip dhcp pool vlan60
network 192.1.60.0 255.255.255.0
default-route 192.1.60.254
exit

ip dhcp pool vlan70
network 192.1.70.0 255.255.255.0
default-route 192.1.70.254
exit

# S3

service dhcp

interface vlan 50
ip helper-address 11.1.0.2
exit
interface vlan 60
ip helper-address 11.1.0.2
exit
interface vlan 70
ip helper-address 11.1.0.2
exit

# S4

service dhcp

interface vlan 50
ip helper-address 11.1.0.2
exit
interface vlan 60
ip helper-address 11.1.0.2
exit
interface vlan 70
ip helper-address 11.1.0.2
exit

```

```
# AC1

ac-controller
capwap ctrl-ip 11.1.0.21
exit

wlan-config 1 Ruijie-teacher_1
tunnel local
exit
wlan-config 2 Ruijie-student_2
tunnel local
wlan-based per-user-limit down-streams average-data-rate 800 burst-data-rate 1600
exit

wlansec 1
security rsn enable
security rsn ciphers aes enable
security rsn akm psk enable
security rsn akm psk set-key ascii p0-p0-p0-
exit

ap-group GZ
interface-mapping 1 60
interface-mapping 2 70
exit

wlan hot-backup 11.1.0.22
context 1
priority level 7
ap-group GZ
exit
wlan hot-backup enable
exit

# AP上线后，用下面的方式加入GZ组
ap-config xxxx.xxxx.xxxx
ap-group GZ
exit

ap-config xxxx.xxxx.xxxx
ap-name GZXQ-AP520-01
exit

ap-config xxxx.xxxx.xxxx
ap-name GZXQ-AP520-02
exit

ap-config xxxx.xxxx.xxxx
ap-name GZXQ-AP520-03
exit

wids
whitelist mac-address e0d4.64e0.bcad
exit

ap-config AP1
sta-limit 30
exit

schedule session 1
schedule session 1 time-range 1 period Mon to Fri time 21:00 to 23:00

wlan-config 1
schedule session 1
exit

ap-config AP1
response-rssi 65 radio 1
response-rssi 65 radio 2
exit
ap-config AP2
response-rssi 65 radio 1
response-rssi 65 radio 2
exit
ap-config AP3
response-rssi 65 radio 1
response-rssi 65 radio 2
exit

ac-controller
802.11b network rate 1 disabled
802.11g network rate 1 disabled
802.11b network rate 2 disabled
802.11g network rate 2 disabled
802.11b network rate 5 disabled
802.11g network rate 5 disabled
802.11a network rate 6 disabled
802.11a network rate 9 disabled
exit

```

```
# AC2

ac-controller
capwap ctrl-ip 11.1.0.22
exit

wlan-config 1 Ruijie-teacher_1
tunnel local
exit
wlan-config 2 Ruijie-student_2
tunnel local
wlan-based per-user-limit down-streams average-data-rate 800 burst-data-rate 1600
exit

wlansec 1
security rsn enable
security rsn ciphers aes enable
security rsn akm psk enable
security rsn akm psk set-key ascii p0-p0-p0-
exit

ap-group GZ
interface-mapping 1 60
interface-mapping 2 70
exit

wlan hot-backup 11.1.0.21
context 1
priority level 4
ap-group GZ
exit

wlan hot-backup enable
exit

# AP上线后，用下面的方式加入GZ组
ap-config xxxx.xxxx.xxxx
ap-group GZ
exit


ap-config xxxx.xxxx.xxxx
ap-name GZXQ-AP520-01
exit

ap-config xxxx.xxxx.xxxx
ap-name GZXQ-AP520-02
exit

ap-config xxxx.xxxx.xxxx
ap-name GZXQ-AP520-03
exit

wids
whitelist mac-address e0d4.64e0.bcad
exit

ap-config AP1
sta-limit 30
exit

schedule session 1
schedule session 1 time-range 1 period Mon to Fri time 21:00 to 23:00

wlan-config 1
schedule session 1
exit

ap-config AP1
response-rssi 65 radio 1
response-rssi 65 radio 2
exit
ap-config AP2
response-rssi 65 radio 1
response-rssi 65 radio 2
exit
ap-config AP3
response-rssi 65 radio 1
response-rssi 65 radio 2
exit

ac-controller
802.11b network rate 1 disabled
802.11g network rate 1 disabled
802.11b network rate 2 disabled
802.11g network rate 2 disabled
802.11b network rate 5 disabled
802.11g network rate 5 disabled
802.11a network rate 6 disabled
802.11a network rate 9 disabled
exit

```