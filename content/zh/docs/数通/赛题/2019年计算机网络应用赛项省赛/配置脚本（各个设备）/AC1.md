---
title: AC1
---

```
# 设备命名
hostname GZXQ-WS6008-01

# 配置SSH
no password policy strong
no password policy min-size 
no password policy forced-password-modify

no service password-encryption

no enable secret
enable password 0 admin

username admin privilege 1 password 0 admin
username admin login mode ssh

enable service ssh-server
line vty 0 4
login local
transport input ssh
exit

# 配置物理地址和回环地址
interface gigabitEthernet 0/1
no switchport
ip address 10.1.0.9 30
exit
interface loopback 0
ip address 11.1.0.21 32
exit

# 配置OSPF
router ospf 10
network 10.1.0.8 0.0.0.3 area 1
network 11.1.0.21 0.0.0.0 area 1
area 1 nssa no-summary 
exit

# 配置无线及其优化

ac-controller
capwap ctrl-ip 11.1.0.21
exit

wlan-config 1 Ruijie-teacher_1
# 配置本地转发
tunnel local
exit
wlan-config 2 Ruijie-student_2
# 配置本地转发
tunnel local
# 配置无线QOS
wlan-based per-user-limit down-streams average-data-rate 800 burst-data-rate 1600
exit

# 配置教室wifi密码
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

# 只允许PC2连接wifi
wids
whitelist mac-address e0d4.64e0.bcad
exit

# AP1只能被30个无线终端连接
ap-config AP1
sta-limit 30
exit

# 配置无线服务时间段
schedule session 1
schedule session 1 time-range 1 period Mon to Fri time 21:00 to 23:00

wlan-config 1
schedule session 1
exit

# 配置AP的无线终端接入信号强度为65dBm
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

# 关闭低速率应用接入
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