# DevOps Assessment - Full-Stack Deployment Documentation

## Local Setup Guide

### Prerequisites Installation
1. **Install Docker Desktop**: Download from [docker.com](https://www.docker.com/products/docker-desktop/)
2. **Install Git**: Download from [git-scm.com](https://git-scm.com/downloads)
3. **Install Node.js 20+**: Download from [nodejs.org](https://nodejs.org/) (Optional for local development)
4. **Install Python 3.13+**: Download from [python.org](https://www.python.org/downloads/) (Optional for local development)

### Quick Start (Docker Only)
```bash
# Clone the repository
git clone https://github.com/mooazsayyed/devops-assessment-nexgenesis.git
cd devops-assessment-nexgenesis

# Start development environment
docker-compose -f docker-compose.dev.yml up --build -d

# Access the application
# Frontend: http://localhost:3002
# Backend: http://localhost:8002
```

### Local Development with Source Code
```bash
# Backend setup
cd backend
python -m venv venv
source venv/bin/activate  # On Windows: venv\Scripts\activate
pip install -r requirements.txt
python manage.py migrate
python manage.py runserver 8000

# Frontend setup (new terminal)
cd frontend
npm install
npm run dev
```


## Deployed Applications

### Production Environment
- **Application URL**: https//nextgensis.mooazsayyed.live 
- **Backend API**: https://api.nextgensis.mooazsayyed.live/api/hello
- **Frontend**: https://nextgensis.mooazsayyed.live

### Pre-Production Environment  
- **Application URL**: https://preprod.nextgensis.mooazsayyed.live
- **Backend API**: https://preprod.api.nextgensis.mooazsayyed.live/api/hello
- **Frontend**: https://preprod.nextgensis.mooazsayyed.live

## Repository Information

**Forked Repository with Mycode**: https://github.com/mooazsayyed/devops-assessment-nexgenesis
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
- Multi-stage build 
- Non-root user implementation (appuser)
- Alpine Linux base for minimal footprint
- Gunicorn WSGI server for production
- Distroless image gcr.io/distroless/nodejs20-debian12 for frontend

**Build Command**:
```bash
docker build -t devops-backend:{envrionment}+sha ./backend
```

### Frontend Dockerfile (Multi-stage Build)
**Location**: `frontend/Dockerfile`

**Key Features**:
- Multi-stage build with Vite optimization
- Distroless runtime image for security
- Non-root user (nonroot from distroless)
- Serve static files with serve package

PRODUCTION SERVER DOCKER IMAGES

Image size specifications
backend image size - 157MB on disk  content size 32.6MB
frontend image size - 188MB  on disk  content size     53.8MB

<img width="1121" height="244" alt="image" src="https://github.com/user-attachments/assets/102c9905-afc3-4f0a-97c8-7d6339342619" />

PREPROD SERVER DOCKER IMAGES

Image size specifications
backend image size - 157MB  on disk    content size  32.6MB
frontend image size - 264MB  on disk    content size  55.9MB

<img width="1239" height="205" alt="image" src="https://github.com/user-attachments/assets/8b4e0663-a91c-48cc-8cd7-1f6c483370c8" />


**Build Command**:
```bash
docker build -t devops-frontend:{environment}+sha ./frontend
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
terraform plan"  
terraform apply"
```

## CI/CD Pipeline

### Development Workflow
**File**: `.github/workflows/development.yml`
**URL**: https://github.com/mooazsayyed/devops-assessment-nexgenesis/blob/development/.github/workflows/development.yml

**Pipeline Stages**:
- **Lint and Validate**: Python linting (flake8, black, isort), Frontend linting (ESLint), TypeScript checking
- **Security Scanning**: Bandit security checks, dependency vulnerability scanning
- **Testing**: Backend tests with coverage, frontend build verification
- **Docker Build**: Multi-stage container builds and health checks
- **Image Security**: Trivy container security scanning

### Staging Workflow  
**File**: `.github/workflows/staging.yml`
**URL**: https://github.com/mooazsayyed/devops-assessment-nexgenesis/blob/staging/.github/workflows/staging.yml

**Pipeline Stages**:
- **Quality Gate**: Comprehensive code quality and formatting checks
- **Security Scan**: Advanced security analysis and dependency auditing
- **Build and Test**: Container builds with health verification
- **Integration Test**: Full Docker Compose integration testing
- **Registry Push**: Tagged image deployment to Docker Hub

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
- Push to respective branches (development, staging, production, pre-prod)
- Pull request creation and updates on for prod and preprod
- Manual workflow dispatch
- Environment-specific automated deployments

### Docker Registry
**Images pushed to Docker Hub**:
- Backend: `mooaz/devops-backend:prod-sha-{commit}`
- Frontend: `mooaz/devops-frontend:prod-sha-{commit}`
- Staging: `mooaz/devops-backend:staging-{commit}`
- Development: Should be Tagged for testing only

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


## Challenges and Solutions

### Challenge: Version Management and Environment Isolation

**Problem**: 
During the deployment process, we encountered version conflicts in which newer application versions were being cached, and separate environment isolation disrupted the deployment rhythm. The main issues were:

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

This approach resolved versioning conflicts and established clear environment boundaries, enabling consistent, predictable deployments across all environments.

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
**Production URL**: https://nextgensis.mooazsayyed.live
**Pre-prod URL**: https://api.nextgensis.mooazsayyed.live

All requirements have been successfully implemented with additional enhancements for production-ready deployment, including multi-environment support, comprehensive security measures, and automated infrastructure management.
