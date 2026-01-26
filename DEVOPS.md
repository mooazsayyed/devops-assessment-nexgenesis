# DevOps Assessment - Full-Stack Deployment Documentation

## Deployed Applications

### Production Environment
- **Application URL**: https//nextgensis.mooazsayyed.live 
- **Backend API**: https://api.nextgensis.mooazsayyed.live
- **Frontend**: https://nextgensis.mooazsayyed.live

### Pre-Production Environment  
- **Application URL**: https://preprod.nextgensis.mooazsayyed.live
- **Backend API**: https://preprod.api.nextgensis.mooazsayyed.live
- **Frontend**: https://preprod.nextgensis.mooazsayyed.live

## Repository Information

**Primary Forked Repository**: https://github.com/mooazsayyed/devops-assessment-nexgenesis
**Original Source**: https://github.com/Nexgensis/devops-assessment

### Branch Structure
<!-- - **main**: Base development branch -->
- **production**: Production deployment branch
- **pre-prod**: Pre-production deployment branch  
- **staging**: Staging environment branch
- **development**: Development environment branch

### Environment Isolation Strategy
Each environment runs isolated containers with separate:
- Port mappings
- Environment variables
- Database configurations
- Network configurations

## Docker Configuration

### Backend Dockerfile (Multi-stage Build)
**Location**: `backend/Dockerfile`

**Key Features**:
- Multi-stage build for optimized image size
- Non-root user implementation (appuser)
- Alpine Linux base for minimal footprint
- Gunicorn WSGI server for production

**Build Command**:
```bash
docker build -t devops-backend ./backend
```

### Frontend Dockerfile (Multi-stage Build)
**Location**: `frontend/Dockerfile`

**Key Features**:
- Multi-stage build with Vite optimization
- Distroless runtime image for security
- Non-root user (nonroot from distroless)
- Serve static files with serve package

**Build Command**:
```bash
docker build -t devops-frontend ./frontend
```

### Docker Compose Configurations

#### Production Environment
**File**: `docker-compose.prod.yml`
```bash
docker-compose -f docker-compose.prod.yml up -d
```

#### Pre-Production Environment  
**File**: `docker-compose.preprod.yml`
```bash
docker-compose -f docker-compose.preprod.yml up -d
```

#### Development Environment
**File**: `docker-compose.dev.yml`
```bash
docker-compose -f docker-compose.dev.yml up -d
```

#### Staging Environment
**File**: `docker-compose.staging.yml`
```bash
docker-compose -f docker-compose.staging.yml up -d
```

### Key Docker Compose Features
- Environment-specific port mappings
- Isolated networks per environment
- Volume mounts for static files
- Environment variable configuration
- Service health checks

## Infrastructure as Code (Terraform)

### AWS Infrastructure Provisioning
**Location**: `Terraform/`

**Resources Managed**:
- **EC2 Instances**: Production and Pre-prod application servers
- **GitHub Runner**: Self-hosted runner for CI/CD (i-0a3ec543ba7c25239)
- **Security Groups**: HTTP/HTTPS/SSH access control
- **Elastic IPs**: Static IP addresses for environments
- **S3 Backend**: Remote state storage with DynamoDB locking

**Key Infrastructure**:
- Production Server: i-04134e67e58a562ca (3.231.187.192)  
- Pre-prod Server: i-0937c46a11f153a92 (54.87.192.112)
- GitHub Runner: i-0a3ec543ba7c25239 (34.227.18.99)

**Terraform Commands**:
```bash
terraform init
terraform plan -var-file="production.tfvars"  
terraform apply -var-file="production.tfvars"
```

## CI/CD Pipeline (GitHub Actions)

### Production Workflow
**File**: `.github/workflows/production.yml`
**URL**: https://github.com/mooazsayyed/devops-assessment-nexgenesis/blob/production/.github/workflows/production.yml

**Pipeline Features**:
- Self-hosted runner execution
- Docker image building and pushing to Docker Hub
- Environment-specific deployment
- Automated container restart
- Image cleanup for storage optimization

### Pre-Production Workflow  
**File**: `.github/workflows/pre-prod.yml`
**URL**: https://github.com/mooazsayyed/devops-assessment-nexgenesis/blob/pre-prod/.github/workflows/pre-prod.yml

### Workflow Triggers
- Push to respective branches (production, pre-prod)
- Manual workflow dispatch
- Environment-specific deployments

### Docker Registry
**Images pushed to Docker Hub**:
- Backend: `mooaz/devops-backend:prod-sha-{commit}`
- Frontend: `mooaz/devops-frontend:prod-sha-{commit}`

## Local Development Setup

### Prerequisites
- Docker and Docker Compose installed
- Node.js 20+ for frontend development  
- Python 3.13+ for backend development

### Clone Repository
```bash
git clone https://github.com/mooazsayyed/devops-assessment-nexgenesis.git
cd devops-assessment-nexgenesis
```

### Environment Variables Setup
Create environment files in `envs/` directory:
- `envs/development/backend.env`
- `envs/staging/backend.env`  
- `envs/preprod/backend.env`

### Run Development Environment
```bash
docker-compose -f docker-compose.dev.yml up --build
```

### Access Local Application
- Frontend: http://localhost:3002
- Backend: http://localhost:8002

## Challenges and Solutions

### Challenge: Version Management and Environment Isolation

**Problem**: 
During the deployment process, we encountered version conflicts where newer application versions were getting cached, and separate environment isolation was disrupting the deployment rhythm. The main issues were:

1. Docker image versions were not properly tagged with commit-specific identifiers
2. Environment-specific containers were interfering with each other
3. Old images were consuming excessive storage space
4. Rolling deployments were inconsistent across environments

**Solution**: 
We implemented a comprehensive version management strategy:

1. **Commit-based Tagging**: Implemented SHA-based image tagging (`prod-sha-{commit}`) to ensure unique versions for each deployment

2. **Environment Isolation**: Created separate Docker Compose files for each environment with:
   - Unique container names per environment
   - Isolated network configurations  
   - Environment-specific port mappings
   - Separate volume mounts

3. **Image Cleanup Strategy**: Added automated cleanup in CI/CD pipelines to remove old images and free up storage space

4. **Deployment Orchestration**: Implemented proper container restart sequences in GitHub Actions to ensure clean deployments

This approach resolved the versioning conflicts and established clear environment boundaries, enabling consistent and predictable deployments across all environments.

## Security Implementation

### Secrets Management
- **GitHub Secrets**: All sensitive data stored in GitHub repository secrets
- **Environment Variables**: No hardcoded credentials in codebase
- **Docker Registry**: Secure token-based authentication

### Non-Root User Implementation
- **Backend**: Custom `appuser` with UID/GID 1001
- **Frontend**: Distroless nonroot user implementation
- **File Permissions**: Proper ownership and restricted access

### Infrastructure Security
- **Security Groups**: Limited to HTTP (80), HTTPS (443), and SSH (22) ports
- **Terraform State**: Encrypted S3 backend with DynamoDB locking
- **SSH Keys**: Properly secured and gitignored

## Best Practices Implemented

### Containerization
- Multi-stage Docker builds for optimized image sizes
- Distroless base images for enhanced security
- Non-root user execution in all containers
- Comprehensive .dockerignore files for build optimization

### CI/CD Pipeline
- Self-hosted runner for cost optimization and control
- Environment-specific deployment strategies  
- Automated image tagging with commit SHA
- Proper secret management with GitHub Secrets
- Image cleanup for storage optimization

### Infrastructure as Code
- Terraform for reproducible infrastructure
- Environment-specific variable files
- Remote state storage with locking
- Resource tagging for organization and billing

### Security
- No hardcoded secrets or API keys
- Environment variable configuration
- Comprehensive .gitignore patterns
- SSH key and certificate protection
- Cloud credential security

### Code Organization
- Clear branch strategy for different environments
- Comprehensive documentation
- Automated security validation scripts
- Environment isolation strategies

## Requirements Compliance

### Phase 1: Containerization ✅
- [x] Separate Dockerfiles for Frontend and Backend with multi-stage builds
- [x] Non-root user implementation in both containers
- [x] Docker Compose orchestration with environment variables
- [x] Frontend-Backend communication configuration

### Phase 2: CI/CD Pipeline ✅  
- [x] GitHub Actions workflow triggering on branch pushes
- [x] Docker image building and pushing to public registry (Docker Hub)
- [x] Automated deployment to AWS Cloud infrastructure
- [x] Self-hosted runner implementation

### Phase 3: Infrastructure as Code ✅
- [x] Terraform scripts for AWS EC2 provisioning
- [x] Security Group configuration (ports 80, 443, 22)
- [x] Automated infrastructure deployment

### Phase 4: Documentation ✅
- [x] Comprehensive setup and troubleshooting guide
- [x] Challenge documentation with solutions
- [x] Best practices implementation
- [x] Screenshots and deployment evidence

## Deployment Evidence

**Repository**: https://github.com/mooazsayyed/devops-assessment-nexgenesis
**Production URL**: http://3.231.187.192
**Pre-prod URL**: http://54.87.192.112

All requirements have been successfully implemented with additional enhancements for production-ready deployment including multi-environment support, comprehensive security measures, and automated infrastructure management.
