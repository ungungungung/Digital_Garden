---
title: RLDP防护
---
为规避网络末端接入设备上出现环路影响全网，要求在福州校区接入设备S2进行防环处理。具体要求如下：
-  终端接口下开启 RLDP防止环路，检测到环路后处理方式为 Shutdown-Port

```
Ruijie(config-if-GigabitEthernet 0/1)#rldp port loop-detect shutdown-port
```
