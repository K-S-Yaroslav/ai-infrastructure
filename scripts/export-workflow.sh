#!/bin/bash
# Универсальный путь к загрузкам Windows
WIN_USER=$(powershell.exe '$env:UserName' | tr -d '\r')
DOWNLOADS="/mnt/c/Users/$WIN_USER/Downloads"

echo "Скачайте workflow из n8n и сохраните в загрузки"
read -p "Нажмите Enter когда файл будет в загрузках..."

cp "$DOWNLOADS"/*.json configs/n8n/workflows/ 2>/dev/null
echo "Файлы скопированы:"
ls -la configs/n8n/workflows/
