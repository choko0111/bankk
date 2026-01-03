#!/bin/bash

IMAGE_NAME=bank-tests

echo ">>> Сборка Docker-образа: $IMAGE_NAME"
docker build -t $IMAGE_NAME .

# Получаем имя текущей папки (проекта)
PROJECT_NAME=$(basename "$(pwd)")

# Формируем правильное имя сети
COMPOSE_NETWORK="${PROJECT_NAME}_bank-network"

echo ">>> Проверяем существующие сети"
docker network ls | grep bank

echo ">>> Запуск тестов в сети: $COMPOSE_NETWORK"
docker run --rm --network "$COMPOSE_NETWORK" $IMAGE_NAME bash -c "pytest --junitxml=/app/reports/raw/results.xml --tb=short"