#!/bin/bash

set -e

echo ">>> Сборка и запуск тестов"
docker compose up --build --exit-code-from tests tests
