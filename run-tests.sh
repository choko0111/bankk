#!/bin/bash

IMAGE_NAME=bank-tests

echo ">>> Сборка Docker-образа: $IMAGE_NAME"
docker build -t $IMAGE_NAME -f ./Dockerfile .

# new
echo ">>> Запуск тестов"
docker run --rm --network bank-network \
  -e BACKEND_URL=http://backend:4111/api \
  $IMAGE_NAME
