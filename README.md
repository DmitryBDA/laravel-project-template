# Laravel Docker Environment

Полноценное Docker-окружение для локальной разработки Laravel 13.

## Технологии

| Технология | Версия |
|---|---|
| PHP | 8.4 FPM |
| Laravel | 13 |
| Nginx | Alpine |
| PostgreSQL | 17 |
| Redis | Alpine |
| Node.js | 22 |
| Vite | Latest |
| Docker Compose | Latest |

Окружение подготовлено для:

- Windows + WSL2
- Linux
- Docker Desktop

---

# Требования

Перед началом должны быть установлены:

- Docker
- Docker Compose
- Git
- WSL2 (Windows)

Проверка:

```bash
docker --version
docker compose version
git --version
```

---

# Установка проекта

## Клонирование

SSH:

```bash
git clone git@github.com:DmitryBDA/laravel-project.git
```

или HTTPS:

```bash
git clone https://github.com/DmitryBDA/laravel-project.git
```

Переход в проект:

```bash
cd laravel-project
```

---

# Настройка Laravel

Перейти в Laravel:

```bash
cd src
```

Создать файл окружения:

```bash
cp .env.example .env
```

Вернуться назад:

```bash
cd ..
```

Laravel `.env` должен содержать:

```env
APP_NAME=Laravel
APP_ENV=local
APP_DEBUG=true
APP_URL=http://localhost:8080


DB_CONNECTION=pgsql
DB_HOST=postgres
DB_PORT=5432
DB_DATABASE=laravel
DB_USERNAME=laravel
DB_PASSWORD=secret


CACHE_STORE=redis

SESSION_DRIVER=redis

QUEUE_CONNECTION=redis


REDIS_CLIENT=phpredis
REDIS_HOST=redis
REDIS_PASSWORD=null
REDIS_PORT=6379


VITE_APP_URL=http://localhost:8080
```

---

# Запуск Docker

## Сборка контейнеров

```bash
docker compose build
```

---

## Запуск

```bash
docker compose up -d
```

После запуска должны работать:

```text
laravel_nginx
laravel_php
laravel_postgres
laravel_redis
laravel_node
```

Проверка:

```bash
docker compose ps
```

---

# Установка зависимостей

## PHP зависимости

```bash
docker compose exec php composer install
```

---

## Laravel ключ

```bash
docker compose exec php php artisan key:generate
```

---

## Права Laravel

```bash
docker compose exec php chmod -R 775 storage bootstrap/cache
```

---

## Миграции

```bash
docker compose exec php php artisan migrate
```

Проверка:

```bash
docker compose exec php php artisan migrate:status
```

---

# Node и Vite

Node контейнер запускается автоматически.

Установка зависимостей:

```bash
docker compose exec node npm install
```

После установки перезапустить:

```bash
docker compose restart node
```

Проверить:

```bash
docker compose logs node
```

Ожидаемый результат:

```
VITE ready

Local:
http://localhost:5173
```

---

# Доступ к проекту

Laravel:

```
http://localhost:8080
```

Vite:

```
http://localhost:5173
```

PostgreSQL:

```
localhost:5432
```

Redis:

```
localhost:6379
```

---

# Docker команды

## Запуск

```bash
docker compose up -d
```

---

## Остановка

```bash
docker compose down
```

---

## Перезапуск

```bash
docker compose restart
```

---

## Статус контейнеров

```bash
docker compose ps
```

---

## Логи всех контейнеров

```bash
docker compose logs -f
```

---

## Логи Nginx

```bash
docker compose logs -f nginx
```

---

## Логи PHP

```bash
docker compose logs -f php
```

---

## Логи Node/Vite

```bash
docker compose logs -f node
```

---

# Работа внутри контейнеров

## PHP

```bash
docker compose exec php bash
```

---

## Node

```bash
docker compose exec node sh
```

---

## PostgreSQL

```bash
docker compose exec postgres bash
```

---

# Laravel команды

Очистка кеша:

```bash
docker compose exec php php artisan optimize:clear
```

---

Миграции:

```bash
docker compose exec php php artisan migrate
```

---

Откат:

```bash
docker compose exec php php artisan migrate:rollback
```

---

Создание контроллера:

```bash
docker compose exec php php artisan make:controller ExampleController
```

---

Создание модели:

```bash
docker compose exec php php artisan make:model Example
```

---

Tinker:

```bash
docker compose exec php php artisan tinker
```

---

# Проверка Redis

Войти:

```bash
docker compose exec php php artisan tinker
```

Выполнить:

```php
Cache::put('test','redis works',60);

Cache::get('test');
```

Ответ:

```
redis works
```

---

# Проверка PHP

Версия:

```bash
docker compose exec php php -v
```

Расширения:

```bash
docker compose exec php php -m
```

Redis:

```bash
docker compose exec php php -m | grep redis
```

---

# Проверка Node

Версия:

```bash
docker compose exec node node -v
```

npm:

```bash
docker compose exec node npm -v
```

---

# Production build

Проверка сборки:

```bash
docker compose exec node npm run build
```

---

# Структура проекта

```
laravel-project
│
├── .gitignore
├── docker-compose.yml
│
├── docker
│   │
│   ├── nginx
│   │   └── default.conf
│   │
│   └── php
│       ├── Dockerfile
│       └── php.ini
│
├── src
│   │
│   ├── app
│   ├── artisan
│   ├── bootstrap
│   ├── config
│   ├── database
│   ├── public
│   ├── resources
│   └── routes
│
└── README.md
```

---

# Git Workflow

Получить изменения:

```bash
git pull
```

Создать ветку:

```bash
git checkout -b feature/example
```

Добавить изменения:

```bash
git add .
```

Commit:

```bash
git commit -m "Описание изменений"
```

Отправить:

```bash
git push origin feature/example
```

---

# Troubleshooting

## Node контейнер не запускается

Проверить:

```bash
docker compose ps -a
```

Логи:

```bash
docker compose logs node
```

---

## Laravel не открывается

Проверить:

```bash
docker compose ps
```

Логи:

```bash
docker compose logs nginx
```

---

## Ошибка прав Laravel

Выполнить:

```bash
docker compose exec php chmod -R 775 storage bootstrap/cache
```

---

## Redis не работает

Проверка:

```bash
docker compose exec redis redis-cli ping
```

Ответ:

```
PONG
```

---

# Лицензия

Проект используется для разработки и обучения.
