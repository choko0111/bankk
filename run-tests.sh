#!/bin/bash

echo ">>> Запуск тестов"
docker-compose up --build --abort-on-container-exit
