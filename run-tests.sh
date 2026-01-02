#!/bin/bash

IMAGE_NAME=bank-tests

echo ">>> Сборка Docker-образа: $IMAGE_NAME"
docker build -t $IMAGE_NAME -f ./Dockerfile .

echo ">>> Запуск тестов"
docker run --rm $IMAGE_NAME