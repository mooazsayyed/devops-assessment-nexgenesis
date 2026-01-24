#!/bin/bash
set -e

echo "Environment Status Check"
echo "======================="
echo ""

# Function to check service health
check_service() {
    local env=$1
    local backend_port=$2
    local frontend_port=$3
    
    echo "Checking $env environment:"
    
    # Check if containers are running
    backend_container="devops-backend-$env"
    frontend_container="devops-frontend-$env"
    
    if docker ps --format "table {{.Names}}" | grep -q "$backend_container"; then
        echo "  Backend container running"
        
        # Check health endpoint
        if curl -s http://localhost:$backend_port/health/ > /dev/null 2>&1; then
            echo "  Backend health check: PASS"
            # Get environment info
            health_data=$(curl -s http://localhost:$backend_port/health/)
            echo "  Environment: $(echo $health_data | jq -r '.environment' 2>/dev/null || echo 'unknown')"
        else
            echo "  Backend health check: FAIL"
        fi
    else
        echo "  Backend container not running"
    fi
    
    if docker ps --format "table {{.Names}}" | grep -q "$frontend_container"; then
        echo "  Frontend container running"
        
        if curl -s http://localhost:$frontend_port > /dev/null 2>&1; then
            echo "  Frontend health check: PASS"
        else
            echo "  Frontend health check: FAIL"
        fi
    else
        echo "  Frontend container not running"
    fi
    
    echo "  URLs:"
    echo "    Backend:  http://localhost:$backend_port"
    echo "    Frontend: http://localhost:$frontend_port"
    echo "    Health:   http://localhost:$backend_port/health/"
    echo ""
}

# Check all environments
check_service "dev" "8001" "5174"
check_service "staging" "8002" "5175" 
check_service "preprod" "8003" "5176"
check_service "prod" "8004" "5177"

echo "Docker Resources:"
echo "  Running containers: $(docker ps -q | wc -l)"
echo "  Total images: $(docker images -q | wc -l)"
echo "  Total volumes: $(docker volume ls -q | wc -l)"