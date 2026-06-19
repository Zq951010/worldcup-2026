#!/bin/bash
# World Cup 2026 - GitHub Pages 部署脚本

echo "=========================================="
echo "2026 FIFA世界杯预测系统 - GitHub Pages 部署"
echo "=========================================="
echo ""

# 检查参数
if [ -z "$1" ]; then
    echo "用法: ./deploy.sh <你的GitHub用户名>"
    echo "示例: ./deploy.sh john Doe"
    exit 1
fi

GITHUB_USER=$1
REPO_NAME="worldcup-2026"
REMOTE_URL="https://github.com/$GITHUB_USER/$REPO_NAME.git"

echo "GitHub 用户名: $GITHUB_USER"
echo "仓库地址: $REMOTE_URL"
echo ""

# 检查 git
git status > /dev/null 2>&1
if [ $? -ne 0 ]; then
    echo "错误: 当前目录不是 Git 仓库"
    exit 1
fi

# 添加远程仓库
git remote remove origin 2>/dev/null
git remote add origin "$REMOTE_URL"

echo "正在推送到 GitHub..."
git push -u origin main

if [ $? -eq 0 ]; then
    echo ""
    echo "✅ 推送成功!"
    echo ""
    echo "下一步:"
    echo "1. 访问 https://github.com/$GITHUB_USER/$REPO_NAME"
    echo "2. 点击 Settings → Pages"
    echo "3. Source 选择 'Deploy from a branch'"
    echo "4. 分支选择 'main'，点击 Save"
    echo ""
    echo "等待 1-2 分钟后，访问:"
    echo "🌐 https://$GITHUB_USER.github.io/$REPO_NAME"
else
    echo ""
    echo "❌ 推送失败"
    echo "请确保:"
    echo "1. 已在 GitHub 创建仓库: $REPO_NAME"
    echo "2. 已配置 GitHub 认证 (git credential 或 SSH key)"
fi
