---
title: git
---
```
git init  # 当前目录初始化仓库

git add .  # 所有文件提交给暂存区

git commit -m '描述'  # 把暂存区的文件提交给仓库

git branch -M main  # 切换分支为main

# 新增远程仓库地址
git remote add origin https://github.com/username/test.git

# 设置远程仓库地址 (必须要先新增才可以设置)
git remote set-url origin https://github.com/username/test.git

git push -u origin main  # 把本地仓库上传到远程仓库

# 配置http代理服务器
git config --global http.proxy http://127.0.0.1:7890

# 配置https代理服务器
git config --global https.proxy http://127.0.0.1:7890

git log  # 查看git日志

git version  # 查看git版本

git config --global --list  # 查看全局配置

git config --global user.name 'username'  # 配置用户名

git config --global user.email 'useremail'  # 配置用户邮箱

```
