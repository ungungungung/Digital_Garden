---
title: 前缀列表匹配nat
---
```
ip nat pool nat_pool prefix-length 24
address interface GigabitEthernet 0/4 match interface GigabitEthernet 0/4
exit
ip nat inside source list 110 pool nat_pool overload
```
