---
title: BPDU保护
---
为规避网络末端接入设备上出现环路影响全网，要求在福州校区接入设备S2进行防环处理。具体要求如下：
-  终端接口开启BPDU防护不能接收 BPDU报文
-  如果端口被 BPDU Guard检测进入 Err-Disabled状态，再过 300 秒后会自动恢复（基于接口部署策略），重新检测是否有环路

```
Ruijie(config-if-GigabitEthernet 0/1)#spanning-tree bpduguard enable
Ruijie(config-if-GigabitEthernet 0/1)#errdisable recovery interval 300
```
