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

docker compose exec -T -w /var/www php composer install


echo
echo "Generating APP_KEY..."

docker compose exec -T -w /var/www php php artisan key:generate --force


echo
echo "Setting Laravel permissions..."

docker compose exec -T -w /var/www php chmod -R ug+rwX storage bootstrap/cache


echo
echo "Installing Node dependencies..."

docker compose exec -T -w /var/www node npm install


echo
echo "Running migrations..."

docker compose exec -T -w /var/www php php artisan migrate


echo
echo "======================================"
echo " Installation completed successfully!"
echo "======================================"

echo
echo "Laravel:"
echo "http://localhost:8080"

echo
echo "Vite:"
echo "http://localhost:5173"
