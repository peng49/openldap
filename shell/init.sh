#!/bin/bash

# 安装 slapd 需要输入密码
apt update && echo "password" | apt install slapd -y