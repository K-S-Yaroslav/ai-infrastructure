
# Локальная AI-инфраструктура с Multi-Agent системой

[![Status](https://img.shields.io/badge/status-MVP_completed-blue.svg)]()
[![Platform](https://img.shields.io/badge/platform-WSL2%20%7C%20Docker-blue)]()
[![GPU](https://img.shields.io/badge/GPU-RTX%203050%208GB-green)]()

Полностью локальная (self-hosted) система для работы ИИ-агентов с Multi-Agent архитектурой. Управление через Telegram-бота. Все вычисления происходят на локальном GPU, данные не покидают компьютер.

## Архитектура системы

```text

Telegram Bot
      ↓
  ngrok (туннель)
      ↓
n8n (оркестратор)
      ↓
Multi-Agent цепочка:
Manager → Worker → Corrector → Critic
      ↓
Ollama (Qwen2.5 7B + 1.5B)
      ↓
PostgreSQL (хранение состояний)
```
## Технологический стек

| Компонент | Технология | Назначение |
|-----------|------------|------------|
| **AI Models** | Qwen2.5 7B, Qwen2.5 1.5B | Генерация и коррекция текста |
| **Inference** | Ollama + NVIDIA GPU | Локальный запуск LLM |
| **Orchestration** | n8n | Управление цепочкой агентов |
| **Database** | PostgreSQL | Хранение состояний n8n |
| **Tunneling** | ngrok | Публичный доступ к локальному серверу |
| **Platform** | WSL2 (Ubuntu) | Среда выполнения |

## Быстрый старт

### Требования
- Windows 11 с WSL2
- Docker Desktop с NVIDIA Container Toolkit
- NVIDIA GPU с 8+ ГБ VRAM
- ngrok аккаунт

### Установка

```bash
# Клонируйте репозиторий
git clone https://github.com/K-S-Yaroslav/ai-infrastructure.git
cd ai-infrastructure

# Создайте .env файл
cp .env.example .env
nano .env  # Заполните свои данные

# Запустите систему
make up

# Загрузите модели
make models
```
## Производительность

| Модель | VRAM | Tokens/s | Назначение|
|--------|------|----------|-----------|
| Qwen2.5 7B | 4.7 ГБ | ~36 | Manager, Worker |
| Qwen2.5 1.5B | 0.9 ГБ | ~100+ токенов/сек | Corrector |
### Железо: Ryzen 7 3700X, 64GB RAM, RTX 3050 8GB

## Структура проекта
```text
.
├── docker-compose.yml    # Основной конфиг сервисов
├── Makefile              # Команды управления
├── .env.example          # Шаблон переменных
├── configs/              # Конфигурационные файлы
│   ├── n8n/              # Workflows n8n
└── scripts/              # Скрипты автоматизации
```

## Roadmap

- Базовая инфраструктура (Docker + Ollama + n8n)
- Простой Telegram бот
- Multi-Agent система (Manager → Worker → Corrector)

## Автор
`K-S-Yaroslav` — GitHub

## Лицензия
[MIT](LICENSE) © 2026 Yaroslav
