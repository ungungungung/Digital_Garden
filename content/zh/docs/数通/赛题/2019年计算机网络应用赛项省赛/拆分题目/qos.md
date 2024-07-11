---
title: qos
---
为了防止突发数据过大并导致网络拥挤，必须对接入的用户流量加以限制。具体要求如下：
-  福州校区接入设备S5的Gi0/1至Gi0/10接口入方向设置接口限速，限速10Mbps,猝发流量1024 kbytes；
-  转发路由器R3服务节点在带宽为2Mbps的S3/0接口做流量整形；
-  转发路由器R3服务节点在G0/0接口做流量监管，上行报文流量不能超过10Mbps，Burst-normal为1M bytes, Burst-max为2M bytes如果超过流量限制则将违规报文丢弃。

```
# S5

interface range gigabitEthernet 0/1 - 10
rate-limit input 10000 1024
exit

```

```
# R3

# 题目要求s3/0,但是设备没有，故用s2/1代替
interface serial 2/1
traffic-shape rate 2000000
exit

interface gigabitEthernet 0/0
rate-limit input 10000000 1000000 2000000 conform-action continue exceed-action drop
exit

```