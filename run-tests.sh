# run-tests.sh
#!/bin/bash

echo ">>> Сборка Docker-образа: bank-tests"
docker build -t bank-tests -f Dockerfile.tests .

# Сначала запускаем бэкенд
echo ">>> Запуск бэкенда"
docker-compose up -d backend

# Ждем пока бэкенд запустится
echo ">>> Ожидание запуска бэкенда..."
sleep 15

# Проверяем доступность
echo ">>> Проверка доступности бэкенда..."
docker-compose exec backend curl -f http://localhost/api/swagger || echo "Бэкенд не отвечает"

# Получаем ID сети бэкенда
NETWORK_ID=$(docker network ls --filter name=$(basename $(pwd))_default -q)

if [ -z "$NETWORK_ID" ]; then
    echo ">>> Сеть не найдена, создаем новую..."
    NETWORK_ID=$(docker network create test-network)
fi

echo ">>> Запуск тестов в сети $NETWORK_ID"
docker run --rm \
  --network $NETWORK_ID \
  -e BACKEND_URL=http://backend:80 \
  -v $(pwd)/reports:/app/reports \
  bank-tests \
  sh -c "
    echo 'Проверяем подключение к бэкенду...'
    curl -v http://backend:80/api/swagger || echo 'Не удалось подключиться'
    echo 'Запуск тестов...'
    pytest src/main/api/tests/ -v --alluredir=/app/reports
  "