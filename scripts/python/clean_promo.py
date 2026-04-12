#!/usr/bin/env python3
import sys
import json
import re

# Читаем входные данные из n8n
input_data = json.loads(sys.stdin.read())

# Получаем текст из Manager
# Структура данных может немного отличаться, поэтому пробуем несколько вариантов
manager_output = input_data.get("output") or input_data.get("text") or ""

# Очищаем от рекламы n8n
cleaned = re.sub(r'\n*This message was sent automatically with n8n.*$', '', manager_output, flags=re.DOTALL)
cleaned = re.sub(r'https?://n8n\.io[^\s]*', '', cleaned)
cleaned = cleaned.strip()

# Возвращаем результат в формате, понятном для n8n
output = {
    "cleanText": cleaned
}
print(json.dumps(output))
