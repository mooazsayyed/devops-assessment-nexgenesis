# Multi-stage Django Backend Dockerfile

# Stage 1: Builder
FROM python:3.13-alpine AS builder

WORKDIR /app

# Install build dependencies
RUN apk add --no-cache \
    gcc \
    musl-dev \
    postgresql-dev \
    python3-dev

# Copy and install Python dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir --user --upgrade pip \
    && pip install --no-cache-dir --user -r requirements.txt \
    && pip install --no-cache-dir --user gunicorn

# Stage 2: Runtime
FROM python:3.13-alpine AS runtime

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    PATH=/home/appuser/.local/bin:$PATH

WORKDIR /app

# Install runtime dependencies only
RUN apk add --no-cache \
    libpq \
    curl \
    bash

# Create non-root user
RUN adduser -D -h /home/appuser appuser

# Copy installed packages from builder stage
COPY --from=builder --chown=appuser:appuser /root/.local /home/appuser/.local

# Copy project files first
COPY --chown=appuser:appuser . .

# Create startup script and staticfiles directory with proper permissions
RUN echo '#!/bin/bash' > /app/start.sh && \
    echo 'python manage.py migrate' >> /app/start.sh && \
    echo 'python manage.py collectstatic --noinput' >> /app/start.sh && \
    echo 'gunicorn --bind 0.0.0.0:8000 --workers 3 --timeout 120 config.wsgi:application' >> /app/start.sh && \
    chmod +x /app/start.sh && \
    mkdir -p /app/staticfiles && \
    chown -R appuser:appuser /app

# Switch to non-root user
USER appuser

# Expose port
EXPOSE 8000

# Health check
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD curl -f http://localhost:8000/health || exit 1

# Start with script that runs migrations first
CMD ["/app/start.sh"]