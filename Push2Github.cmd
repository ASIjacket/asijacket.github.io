@echo off
call git config --global https.proxy http://127.0.0.1:8222
call git status -s
call git commit -a -m Update
call git status -s
call git push
call git config --global --unset http.proxy