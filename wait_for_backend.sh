#!/bin/bash
set -e

echo "Waiting for backend..."

until curl -sf http://backend:4111/api > /dev/null; do
  sleep 2
done

echo "Backend is ready"

pytest -m api --alluredir=/app/reports/allure