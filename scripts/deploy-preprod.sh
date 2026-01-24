#!/bin/bash
set -e

echo "Deploying Pre-Production Environment"
echo "===================================="

# Stop and remove existing containers and volumes
echo "Stopping existing preprod containers..."
docker-compose -f docker-compose.preprod.yml down --volumes --remove-orphans

# Remove dangling images and volumes
echo "Cleaning up dangling resources..."
docker system prune -f
docker volume prune -f

# Build with no cache to ensure fresh build
echo "Building preprod images..."
docker-compose -f docker-compose.preprod.yml build --no-cache

# Start services in background
echo "Starting preprod services in background..."
docker-compose -f docker-compose.preprod.yml up -d

# Wait for services to be healthy
echo "Waiting for services to be healthy..."
sleep 10

# Check health
echo "Checking service health..."
if curl -f http://localhost:8003/health/ > /dev/null 2>&1; then
    echo "Backend health check passed"
else
    echo "Backend health check failed"
fi

if curl -f http://localhost:5176 > /dev/null 2>&1; then
    echo "Frontend health check passed"
else
    echo "Frontend health check failed"
fi

echo ""
echo "Pre-production environment deployed successfully!"
echo "Backend: http://localhost:8003"
echo "Frontend: http://localhost:5176"
echo "Health: http://localhost:8003/health/"
echo ""