#!/bin/bash

IMAGE_NAME=bank-tests

echo ">>> Сборка Docker-образа: $IMAGE_NAME"
docker build -t $IMAGE_NAME .

COMPOSE_NETWORK=test-bank_bank-network

echo ">>> Запуск тестов в сети: $COMPOSE_NETWORK"
docker run --rm \
  --network bank-network \
  bash -c "\
    pytest --junitxml=/app/reports/raw/results.xml --tb=short \
  "
