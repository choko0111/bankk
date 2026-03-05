#!/bin/bash

set -e

docker compose up -d backend

echo ">>> Ожидание готовности backend..."
for i in $(seq 1 30); do
  if curl -sf http://localhost:4111/api > /dev/null 2>&1; then
    echo ">>> Backend готов"
    exit 0
  fi
  sleep 2
done

echo ">>> Backend не поднялся за 60 секунд"
docker compose logs backend
exit 1
