# Base stage - Install dependencies
FROM python:3.10-alpine AS baseimage
WORKDIR /app
COPY requirements.txt .
RUN pip install --user -r requirements.txt

