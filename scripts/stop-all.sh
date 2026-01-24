#!/bin/bash
set -e

echo "Environment Stop Menu"
echo "===================="
echo "1. Stop Development"
echo "2. Stop Staging" 
echo "3. Stop Pre-Production"
echo "4. Stop Production"
echo "5. Stop ALL Environments"
echo "0. Exit"
echo ""
read -p "Enter your choice (0-5): " choice

case $choice in
    1)
        echo "Stopping Development Environment..."
        docker-compose -f docker-compose.dev.yml down --volumes --remove-orphans
        echo "Development environment stopped."
        ;;
    2)
        echo "Stopping Staging Environment..."
        docker-compose -f docker-compose.staging.yml down --volumes --remove-orphans
        echo "Staging environment stopped."
        ;;
    3)
        echo "Stopping Pre-Production Environment..."
        docker-compose -f docker-compose.preprod.yml down --volumes --remove-orphans
        echo "Pre-production environment stopped."
        ;;
    4)
        echo "Stopping Production Environment..."
        docker-compose -f docker-compose.prod.yml down --volumes --remove-orphans
        echo "Production environment stopped."
        ;;
    5)
        echo "Stopping ALL Environments..."
        echo "Stopping Development..."
        docker-compose -f docker-compose.dev.yml down --volumes --remove-orphans
        echo "Stopping Staging..."
        docker-compose -f docker-compose.staging.yml down --volumes --remove-orphans
        echo "Stopping Pre-Production..."
        docker-compose -f docker-compose.preprod.yml down --volumes --remove-orphans
        echo "Stopping Production..."
        docker-compose -f docker-compose.prod.yml down --volumes --remove-orphans
        echo "Cleaning up dangling resources..."
        docker system prune -f
        docker volume prune -f
        echo "All environments stopped and cleaned up."
        ;;
    0)
        echo "Exiting..."
        exit 0
        ;;
    *)
        echo "Invalid choice. Please enter a number between 0-5."
        exit 1
        ;;
esac