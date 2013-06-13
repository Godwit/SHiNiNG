#!/bin/sh
# 启服脚本

# 启动数据库
erl -mnesia dir '"./db_store"' -sname godwit
