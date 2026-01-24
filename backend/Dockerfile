# Simple Django Backend Dockerfile
FROM python:3.13-slim

# Set environment variables
ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1

WORKDIR /app

# Install system dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    build-essential \
    libpq-dev \
    && rm -rf /var/lib/apt/lists/*

# Install Python dependencies
COPY requirements.txt .
RUN pip install --upgrade pip \
    && pip install -r requirements.txt

# Create non-root user
RUN adduser --disabled-password --gecos '' appuser

# Copy project files
COPY . .

# Change ownership to appuser
RUN chown -R appuser:appuser /app

# Switch to non-root user
USER appuser

# Create startup script
RUN echo '#!/bin/bash\n\
    python manage.py migrate\n\
    python manage.py collectstatic --noinput\n\
    python manage.py runserver 0.0.0.0:8000' > /app/start.sh

# Make startup script executable
USER root
RUN chmod +x /app/start.sh
USER appuser

# Expose port
EXPOSE 8000

# Health check
HEALTHCHECK --interval=30s --timeout=30s --start-period=5s --retries=3 \
    CMD python manage.py check || exit 1

# Start with script that runs migrations first
CMD ["/app/start.sh"]