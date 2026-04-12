
# Локальная AI-инфраструктура с Multi-Agent системой

[![Status](https://img.shields.io/badge/status-active-success.svg)]()
[![Platform](https://img.shields.io/badge/platform-WSL2%20%7C%20Docker-blue)]()
[![GPU](https://img.shields.io/badge/GPU-RTX%203050%208GB-green)]()

Полностью локальная (self-hosted) система для работы ИИ-агентов с Multi-Agent архитектурой. Управление через Telegram-бота и веб-интерфейс. Все вычисления происходят на локальном GPU, данные не покидают компьютер.

## Архитектура системы

```text

Telegram Bot
      ↓
  ngrok (туннель)
      ↓
n8n (оркестратор)
      ↓
Multi-Agent цепочка:
Manager → Worker → Corrector → Critic → Synthesizer
      ↓
Ollama (Qwen2.5 7B + 1.5B)
      ↓
PostgreSQL + Redis + Qdrant
```
## Технологический стек

| Компонент | Технология | Назначение |
|-----------|------------|------------|
| **AI Models** | Qwen2.5 7B/1.5B | Генерация, проверка |
| **Inference** | Ollama + NVIDIA GPU | Локальный запуск LLM |
| **Orchestration** | n8n | Управление workflow |
| **Vector DB** | Qdrant | Семантический поиск |
| **Database** | PostgreSQL | Хранение состояний |
| **Cache** | Redis | Кэширование |
| **Tunneling** | ngrok | Публичный доступ |
| **Platform** | WSL2 (Ubuntu) | Среда выполнения |

## Быстрый старт

### Требования
- Windows 11 с WSL2
- Docker Desktop с NVIDIA Container Toolkit
- NVIDIA GPU с 8+ ГБ VRAM

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

## Структура проекта
```text
.
├── docker-compose.yml    # Основной конфиг сервисов
├── Makefile              # Команды управления
├── .env.example          # Шаблон переменных
├── configs/              # Конфигурационные файлы
│   ├── n8n/              # Workflows n8n
│   └── prometheus/       # Конфиг мониторинга
└── scripts/              # Скрипты автоматизации
```

## Производительность

| Модель | VRAM | Tokens/s | Назначение|
|--------|------|----------|-----------|
| Qwen2.5 7B | 4.7 ГБ | ~36 | Основные ответы |
| Qwen2.5 1.5B | 0.9 ГБ | ~68 | Корректор |
| Qwen2.5 1.5B | 0.9 ГБ | ~100+ токенов/сек | Корректор |
| Nomic Embed Text | 0.27 ГБ | N/A | Эмбеддинги для RAG |

### Железо: Ryzen 7 3700X, 64GB RAM, RTX 3050 8GB

## Roadmap

- Базовая инфраструктура
- Простой Telegram бот
- Multi-Agent система (Manager/Worker/Critic/Corrector)
- RAG на документах
- Мониторинг GPU (Prometheus + Grafana)
- Веб-интерфейс (Open WebUI)

## Автор
`K-S-Yaroslav` — GitHub

## Лицензия
MIT License
