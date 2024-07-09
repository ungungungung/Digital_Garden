@echo off

chcp 65001
cd/d %~dp0

rd /s /q docs
md docs
copy CNAME docs

cls

hugo -d docs
echo.
echo 根据上述Hugo编译日志判断是否编译成功，再决定是否上传远程仓库? (y/n)
set /p ch=">"

if %ch%==y (
git add .
git commit -m 'commit'
git push -u origin master
)

pause