FROM mcr.microsoft.com/playwright/python:latest

ARG TEST_PROFILE=api


ENV TEST_PROFILE=${TEST_PROFILE}

WORKDIR /app

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY wait_for_backend.sh /app/wait_for_backend.sh

RUN chmod +x /app/wait_for_backend.sh

COPY . .

CMD ["/app/wait_for_backend.sh"]