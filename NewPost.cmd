@echo off
set /p title=���������:
call npx hexo new post %title%
call "C:\Program_Apps_Files\OFFICE\Typora\Typora.exe" ./source/\_posts/%title%.md