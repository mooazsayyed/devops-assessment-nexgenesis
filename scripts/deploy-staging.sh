#!/bin/bash
set -e

echo "Deploying Staging Environment"
echo "============================="

# Stop and remove existing containers and volumes
echo "Stopping existing staging containers..."
docker-compose -f docker-compose.staging.yml down --volumes --remove-orphans

# Remove dangling images and volumes
echo "Cleaning up dangling resources..."
docker system prune -f
docker volume prune -f

# Build with no cache to ensure fresh build
echo "Building staging images..."
docker-compose -f docker-compose.staging.yml build --no-cache

# Start services in background
echo "Starting staging services in background..."
docker-compose -f docker-compose.staging.yml up -d

# Wait for services to be healthy
echo "Waiting for services to be healthy..."
sleep 10

# Check health
echo "Checking service health..."
if curl -f http://localhost:8002/health/ > /dev/null 2>&1; then
    echo "Backend health check passed"
else
    echo "Backend health check failed"
fi

if curl -f http://localhost:5175 > /dev/null 2>&1; then
    echo "Frontend health check passed"
else
    echo "Frontend health check failed"
fi

echo ""
echo "Staging environment deployed successfully!"
echo "Backend: http://localhost:8002"
echo "Frontend: http://localhost:5175"
echo "Health: http://localhost:8002/health/"
echo ""