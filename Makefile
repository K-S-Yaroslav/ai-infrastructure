.PHONY: help up down logs status clean backup restore

help:
	@echo "Доступные команды:"
	@echo "  make up       - Запустить все сервисы"
	@echo "  make down     - Остановить все сервисы"
	@echo "  make logs     - Показать логи всех сервисов"
	@echo "  make status   - Показать статус контейнеров"
	@echo "  make clean    - Очистить все данные (ОСТОРОЖНО!)"
	@echo "  make backup   - Создать бэкап"
	@echo "  make restore  - Восстановить из бэкапа"

up:
	docker compose up -d

down:
	docker compose down

logs:
	docker compose logs -f

status:
	docker compose ps

clean:
	docker compose down -v
	rm -rf *_data

backup:
	@mkdir -p backups/$$(date +%Y%m%d)
	tar -czf backups/$$(date +%Y%m%d)/ai-infra-backup.tar.gz *_data .env docker-compose.yml configs/

restore:
	@echo "Укажите файл бэкапа: make restore FILE=backups/20240101/ai-infra-backup.tar.gz"
	@if [ -f "$(FILE)" ]; then \
		tar -xzf $(FILE) && \
		echo "Бэкап восстановлен из $(FILE)"; \
	else \
		echo "Файл $(FILE) не найден"; \
	fi
