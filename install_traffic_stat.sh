#!/bin/bash

# 设定仓库 URL
REPO_URL="https://github.com/sdjisds/vps-traffic-monitor.git"
INSTALL_DIR="$HOME/vps-traffic-monitor"

# 更新系统并安装必需的工具
echo "更新系统并安装必需的工具..."
sudo apt update && sudo apt install -y curl bc git

# 克隆 Git 仓库
echo "克隆仓库到 $INSTALL_DIR ..."
git clone "$REPO_URL" "$INSTALL_DIR"

# 进入仓库目录
cd "$INSTALL_DIR"

# 提示用户输入 Telegram Bot Token 和 Chat ID
echo "请输入 Telegram Bot Token:"
read BOT_TOKEN
echo "请输入 Telegram Chat ID:"
read CHAT_ID

# 保存配置到环境变量文件
echo "export BOT_TOKEN=$BOT_TOKEN" >> ~/.bashrc
echo "export CHAT_ID=$CHAT_ID" >> ~/.bashrc

# 刷新环境变量
source ~/.bashrc

# 确保脚本可执行
chmod +x traffic_stat.sh

# 设置定时任务：每天10点执行流量统计脚本
(crontab -l 2>/dev/null; echo "0 10 * * * $INSTALL_DIR/traffic_stat.sh") | crontab -

# 完成安装
echo "安装完成。流量统计脚本将在每天 10:00 自动执行。"
echo "你可以手动执行脚本通过运行 $INSTALL_DIR/traffic_stat.sh 来立即获取流量统计。"