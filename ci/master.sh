#!/bin/sh
set -e

echo "Deploying application production ..."

# vendor/bin/phpunit

git pull origin master

cd ..

# Install dependencies based on lock file
composer install --no-interaction --prefer-dist --optimize-autoloader

# Migrate database
php artisan migrate --force

# Update nd.css
npm update
npm run build

# Clear cache
php artisan optimize:clear

php artisan view:cache
php artisan config:cache
php artisan route:clear

echo "Application deployed!"
