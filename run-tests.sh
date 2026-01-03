#!/bin/bash

IMAGE_NAME=bank-tests

echo ">>> Сборка Docker-образа: $IMAGE_NAME"
docker build -t $IMAGE_NAME .

COMPOSE_NETWORK=bank_net

echo ">>> Запуск тестов в сети: $COMPOSE_NETWORK"

docker run --rm --network test-net \
  -e BACKEND_URL=http://bank_api:4111 \
  $IMAGE_NAME