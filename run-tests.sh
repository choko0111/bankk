#!/bin/bash

IMAGE_NAME=bank-tests

echo ">>> Сборка Docker-образа: $IMAGE_NAME"
docker build -t $IMAGE_NAME .

echo ">>> Запуск тестов"
docker run --rm \
  --network bank-network \
  -e BACKEND_URL=http://backend:4111/api \
  bank-tests
