#!/bin/bash

# check_backend.sh
#!/bin/bash
echo "=== Checking backend ==="

# 1. Запускаем бэкенд
docker-compose up -d backend

# 2. Ждем 20 секунд
echo "Waiting 20 seconds for backend to start..."
sleep 20

# 3. Проверяем статус контейнера
echo "Container status:"
docker-compose ps

# 4. Проверяем логи
echo "Last 20 lines of logs:"
docker-compose logs backend --tail=20

# 5. Проверяем доступность
echo "Testing connectivity:"
curl -v http://localhost:4111/api/swagger 2>&1 | head -20 || echo "curl failed"

# 6. Проверяем порты
echo "Listening ports:"
docker-compose exec backend netstat -tulpn 2>/dev/null || echo "Cannot check ports"

# 7. Если не работает, перезапускаем с большим таймаутом
echo "If not working, trying PHP built-in server directly:"
docker-compose exec backend php -S 0.0.0.0:8080 -t public &
sleep 5
curl http://localhost:8080/api/swagger || echo "Direct PHP server also failed"