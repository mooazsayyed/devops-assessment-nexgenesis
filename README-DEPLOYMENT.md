## Multi-Environment Docker Deployment

### Environment Structure
```
📁 Project Root
├── envs/
│   ├── development/
│   │   ├── backend.env
│   │   └── frontend.env
│   ├── staging/
│   ├── preprod/
│   └── prod/
├── scripts/
│   ├── deploy-dev.sh
│   ├── deploy-staging.sh  
│   ├── deploy-preprod.sh
│   ├── deploy-prod.sh
│   ├── stop-all.sh
│   └── status.sh
├── docker-compose.dev.yml
├── docker-compose.staging.yml
├── docker-compose.preprod.yml
└── docker-compose.prod.yml
```

### Port Mapping
- **Development**: Backend (8001), Frontend (5174)
- **Staging**: Backend (8002), Frontend (5175)  
- **Pre-prod**: Backend (8003), Frontend (5176)
- **Production**: Backend (8004), Frontend (5177)

### Deployment Commands
```bash
# Deploy specific environment
chmod +x scripts/*.sh
./scripts/deploy-dev.sh
./scripts/deploy-staging.sh
./scripts/deploy-preprod.sh
./scripts/deploy-prod.sh

# Check status of all environments
./scripts/status.sh

# Stop all environments
./scripts/stop-all.sh
```

### Health Check
Visit `http://localhost:PORT/health/` for each environment to see:
- Environment name
- Debug status
- Allowed hosts
- Timestamp
- Version

### Manual Commands
```bash
# Development
docker-compose -f docker-compose.dev.yml up -d --build

# Staging
docker-compose -f docker-compose.staging.yml up -d --build

# Pre-production
docker-compose -f docker-compose.preprod.yml up -d --build

# Production
docker-compose -f docker-compose.prod.yml up -d --build
```