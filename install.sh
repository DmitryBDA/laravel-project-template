#!/usr/bin/env bash

set -e

echo "======================================"
echo " Laravel Docker Installer"
echo "======================================"

if [ ! -f "src/.env" ]; then
    echo "Creating Laravel .env..."
    cp src/.env.example src/.env
fi

echo
echo "Building and starting Docker containers..."

docker compose up -d --build

echo
echo "Waiting for PostgreSQL..."

until docker compose exec -T postgres pg_isready -U laravel >/dev/null 2>&1
do
    sleep 2
done

echo "PostgreSQL is ready."

echo
echo "Installing Composer dependencies..."

docker compose exec -T php composer install

echo
echo "Generating APP_KEY..."

docker compose exec -T php php artisan key:generate --force

echo
echo "Setting permissions..."

docker compose exec -T php chmod -R 775 storage bootstrap/cache

echo
echo "Installing Node dependencies..."

docker compose exec -T node npm install

echo
echo "Running migrations..."

docker compose exec -T php php artisan migrate

echo
echo "======================================"
echo " Installation completed successfully!"
echo "======================================"
echo
echo "Laravel: http://localhost:8080"
echo "Vite:     http://localhost:5173"
