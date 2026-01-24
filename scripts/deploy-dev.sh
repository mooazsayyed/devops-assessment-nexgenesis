#!/bin/bash
set -e

echo "Deploying Development Environment"
echo "================================="

# Stop and remove existing containers and volumes
echo "Stopping existing development containers..."
docker-compose -f docker-compose.dev.yml down --volumes --remove-orphans

# Remove dangling images and volumes
echo "Cleaning up dangling resources..."
docker system prune -f
docker volume prune -f

# Build with no cache to ensure fresh build
echo "Building development images..."
docker-compose -f docker-compose.dev.yml build --no-cache

# Start services in background
echo "Starting development services in background..."
docker-compose -f docker-compose.dev.yml up -d

# Wait for services to be healthy
echo "Waiting for services to be healthy..."
sleep 10

# Check health
echo "Checking service health..."
if curl -f http://localhost:8001/health/ > /dev/null 2>&1; then
    echo "Backend health check passed"
else
    echo "Backend health check failed"
fi

if curl -f http://localhost:5174 > /dev/null 2>&1; then
    echo "Frontend health check passed"
else
    echo "Frontend health check failed"
fi

echo ""
echo "Development environment deployed successfully!"
echo "Backend: http://localhost:8001"
echo "Frontend: http://localhost:5174"
echo "Health: http://localhost:8001/health/"
echo ""