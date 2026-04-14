
# Local AI Infrastructure with Multi-Agent System

[![Status](https://img.shields.io/badge/status-MVP_completed-blue.svg)]()
[![Platform](https://img.shields.io/badge/platform-WSL2%20%7C%20Docker-blue)]()
[![GPU](https://img.shields.io/badge/GPU-RTX%203050%208GB-green)]()
[![License](https://img.shields.io/badge/license-MIT-blue)](LICENSE)

> 📖 [Read in Russian / Читать на русском](README_RU.md)

A fully local (self-hosted) system for running AI agents with Multi-Agent architecture. Controlled via Telegram bot. All computations run on local GPU, data never leaves the computer.

## System Architecture

```text

Telegram Bot
      ↓
  ngrok (tunnel)
      ↓
n8n (orchestrator)
      ↓
Multi-Agent chain:
Manager → Worker → Corrector
      ↓
Ollama (Qwen2.5 7B + 1.5B)
      ↓
PostgreSQL (state storage)
```
### Agent Roles

| Агент | Модель | Задача |
|-------|--------|--------|
| **Manager** | Qwen2.5 7B | Analyzes request, creates response plan |
| **Worker** | Qwen2.5 7B | Writes detailed response following the plan |
| **Corrector** | Qwen2.5 1.5B | Fixes spelling and punctuation errors |

## Tech Stack

| Component | Technology  | Purpose  |
|-----------|------------|------------|
| **AI Models** | Qwen2.5 7B, Qwen2.5 1.5B | Text generation and correction |
| **Inference** | Ollama + NVIDIA GPU | Local LLM execution |
| **Orchestration** | n8n | Agent chain management |
| **Database** | PostgreSQL | n8n state storage |
| **Tunneling** | ngrok | Public access to local server |
| **Platform** | WSL2 (Ubuntu) | Runtime environment |

## Quick Start

### Requirements
- Windows 11 с WSL2
- Docker Desktop с NVIDIA Container Toolkit
- NVIDIA GPU с 8+ ГБ VRAM
- ngrok account (free tier)

### Installation

```bash
# Clone repository
git clone https://github.com/K-S-Yaroslav/ai-infrastructure.git
cd ai-infrastructure

# Create .env file
cp .env.example .env
nano .env  # Заполните свои данные

# Start system
docker compose up -d

# Download models
docker exec ai_engine ollama pull qwen2.5:7b-instruct-q4_K_M
docker exec ai_engine ollama pull qwen2.5:1.5b-instruct-q4_K_M
```
## Performance

| Model | VRAM | Speed | Purpose |
|--------|------|----------|-----------|
| Qwen2.5 7B | 4.7 ГБ | ~36 | Manager, Worker |
| Qwen2.5 1.5B | 0.9 ГБ | ~68+| Corrector |
### Hardware: Ryzen 7 3700X, 64GB RAM, RTX 3050 8GB

## Project Structure
```text
.
├── docker-compose.yml    # Main service config
├── Makefile              # Management commands
├── .env.example          # Environment template
├── configs/              # Configuration files
│   ├── n8n/              # n8n workflows
└── scripts/              # Automation scripts
```

## Roadmap

- Basic infrastructure (Docker + Ollama + n8n)
- Simple Telegram bot
- Multi-Agent system (Manager → Worker → Corrector)

## Author
`K-S-Yaroslav` — GitHub

## License
[MIT](LICENSE) © 2026 Yaroslav