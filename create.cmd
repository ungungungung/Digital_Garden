chcp 65001
cd/d %~dp0

rd /s /q docs
md docs
copy CNAME docs

hugo -d docs

set /p ch=是否上传远程仓库? (1/0)

if %ch%==1 (
git add .
git commit -m 'commit'
git push -u origin master
)

pause