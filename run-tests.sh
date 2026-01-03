#!/bin/bash
set -e

IMAGE_NAME="bank-tests"

echo ">>> Сборка Docker-образа: $IMAGE_NAME"
docker build -t "$IMAGE_NAME" .

echo ">>> Проверяем существующие сети"
docker network ls

echo ">>> Используем сеть 'bank-network' (где реально находится backend)"
docker run --rm \
  --network bank-network \
  -e BACKEND_URL="http://backend:4111/api" \
  -v "$(pwd)/test-output:/app/reports" \
  "$IMAGE_NAME" \
  bash -c "pytest --junitxml=/app/reports/raw/results.xml --tb=short"