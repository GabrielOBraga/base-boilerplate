# Stage 1: Build Frontend
FROM node:18-alpine AS frontend-builder

WORKDIR /app/frontend

COPY frontend/package*.json ./
RUN npm install

COPY frontend/ .

RUN npm run build

# Stage 2: Build Backend with Frontend assets
FROM python:3.11-slim

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Install system dependencies (nginx + supervisor only, no node needed)
RUN apt-get update && apt-get install -y \
    libpq-dev \
    gcc \
    nginx \
    supervisor \
    && rm -rf /var/lib/apt/lists/*

# Copy and install Python dependencies
COPY backend/requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy backend code
COPY backend/ .

# Copy frontend build output - serve as static files
COPY --from=frontend-builder /app/frontend/.next/static /var/www/frontend/static
COPY --from=frontend-builder /app/frontend/.next/server /var/www/frontend/server

# Copy nginx config
COPY nginx.conf /etc/nginx/nginx.conf

# Copy supervisor config
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Create directories for supervisor logs and frontend files
RUN mkdir -p /var/log/supervisor /var/www/frontend && \
    nginx -t

EXPOSE 80

CMD ["/usr/bin/supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]