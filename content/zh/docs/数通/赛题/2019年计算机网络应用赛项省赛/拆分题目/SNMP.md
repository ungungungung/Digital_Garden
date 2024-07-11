---
title: SNMP
---
配置S7设备SNMP消息，向主机172.16.0.254发送Trap消息版本采用V2C，读写的Community为“ruijie”，只读的Community为“public”，开启Trap消息。

```
# VSU

snmp-server host 172.16.0.254 traps version 2c ruijie
snmp-server host 172.16.0.254 traps version 2c public
snmp-server enable traps
snmp-server community ruijie rw 
snmp-server community public ro
```
