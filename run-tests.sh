#!/bin/bash

IMAGE_NAME=bank-tests

echo ">>> Сборка Docker-образа: $IMAGE_NAME"
docker build -t $IMAGE_NAME .

COMPOSE_NETWORK=bank_net

echo ">>> Запуск тестов в сети: $COMPOSE_NETWORK"
docker run --rm \
  --network $COMPOSE_NETWORK \
  -e BACKEND_URL=http://backend:4111/api \
  $IMAGE_NAME
