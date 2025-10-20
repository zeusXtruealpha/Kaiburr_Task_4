# CICD Pipeline Repository

This repository contains all CI/CD pipeline configurations, scripts, and documentation for the Kaiburr Task Management System.

## Repository Structure

```
Kaiburr_CICD/
├── workflows/           # GitHub Actions workflow files
├── scripts/            # Setup and deployment scripts
├── docker/             # Docker configurations
├── docs/               # Documentation
└── README.md           # This file
```
## CI/CD (Proof)


[![Backend CI](https://img.shields.io/github/actions/workflow/status/zeusXtruealpha/Kaiburr_Task_1/ci.yml?label=backend%20ci)](https://github.com/zeusXtruealpha/Kaiburr_Task_1/actions)
[![Backend Docker](https://img.shields.io/github/actions/workflow/status/zeusXtruealpha/Kaiburr_Task_1/docker.yml?label=backend%20docker)](https://github.com/zeusXtruealpha/Kaiburr_Task_1/actions)
[![Frontend CI](https://img.shields.io/github/actions/workflow/status/zeusXtruealpha/Kaiburr_Task_3/ci.yml?label=frontend%20ci)](https://github.com/zeusXtruealpha/Kaiburr_Task_3/actions)
[![Frontend Docker](https://img.shields.io/github/actions/workflow/status/zeusXtruealpha/Kaiburr_Task_3/docker.yml?label=frontend%20docker)](https://github.com/zeusXtruealpha/Kaiburr_Task_3/actions)


### Required Secrets (configured in both app repos)

- `DOCKERHUB_USERNAME` = `zeus45`
- `DOCKERHUB_TOKEN` = Docker Hub PAT

## Project Repositories

- **Backend**: `https://github.com/zeusXtruealpha/Kaiburr_Task_1`
- **Frontend**: `https://github.com/zeusXtruealpha/Kaiburr_Task_3`
- **CICD**: `https://github.com/zeusXtruealpha/Kaiburr_CICD` (this repo)

## 🛠️ Features

### CI/CD Pipelines
- **Backend CI**: Maven build, test, security scan, artifact upload
- **Frontend CI**: Node.js build, TypeScript check, security scan
- **Deployment**: Multiple deployment options (GitHub Releases, Cloud Storage)
- **Docker Support**: Both with and without Docker configurations

### Setup Scripts
- **Backend Setup**: `scripts/setup-backend-no-docker.sh/.bat`
- **Frontend Setup**: `scripts/setup-frontend-no-docker.sh/.bat`
- **Docker Setup**: `scripts/setup-backend.sh/.bat`, `scripts/setup-frontend.sh/.bat`

### Docker Configurations
- **Backend Dockerfile**: `docker/Dockerfile.backend`
- **Frontend Dockerfile**: `docker/Dockerfile.frontend`
- **Docker Compose**: `docker/docker-compose.yml`
- **Nginx Config**: `docker/nginx.conf`, `docker/nginx-proxy.conf`

## Quick Start

### 1. Setup Backend Repository
```bash
# Clone the backend repository
git clone https://github.com/zeusXtruealpha/Kaiburr_Task_1.git
cd Kaiburr_Task_1

# Copy and run setup script
cp ../Kaiburr_CICD/scripts/setup-backend-no-docker.sh .
chmod +x setup-backend-no-docker.sh
./setup-backend-no-docker.sh

# Or on Windows
copy ..\Kaiburr_CICD\scripts\setup-backend-no-docker.bat .
.\setup-backend-no-docker.bat
```

### 2. Setup Frontend Repository
```bash
# Clone the frontend repository
git clone https://github.com/zeusXtruealpha/Kaiburr_Task_3.git
cd Kaiburr_Task_3

# Copy and run setup script
cp ../Kaiburr_CICD/scripts/setup-frontend-no-docker.sh .
chmod +x setup-frontend-no-docker.sh
./setup-frontend-no-docker.sh

# Or on Windows
copy ..\Kaiburr_CICD\scripts\setup-frontend-no-docker.bat .
.\setup-frontend-no-docker.bat
```

### 3. Commit and Push
```bash
git add .
git commit -m "Add CI/CD pipeline"
git push origin main
```

## 📋 Workflow Files

### Backend Workflows
- `workflows/backend-ci-no-docker.yml` - CI pipeline without Docker
- `workflows/backend-ci.yml` - CI pipeline with Docker
- `workflows/backend-deploy.yml` - Deployment pipeline

### Frontend Workflows
- `workflows/frontend-ci-no-docker.yml` - CI pipeline without Docker
- `workflows/frontend-ci.yml` - CI pipeline with Docker
- `workflows/frontend-deploy.yml` - Deployment pipeline


### Local Development
```bash
# Start all services
docker-compose -f docker/docker-compose.yml up -d

# View logs
docker-compose -f docker/docker-compose.yml logs -f

# Stop services
docker-compose -f docker/docker-compose.yml down
```

### Production Deployment
```bash
# Build and push images
docker build -f docker/Dockerfile.backend -t your-registry/backend:latest .
docker build -f docker/Dockerfile.frontend -t your-registry/frontend:latest .

# Deploy to production
docker-compose -f docker/docker-compose.yml -f docker/docker-compose.prod.yml up -d
```

### GitHub Actions
- Go to your repository → Actions tab
- View workflow runs and logs
- Check test results and deployment status

### Build Artifacts
- Backend: JAR files uploaded to GitHub Releases
- Frontend: Static files deployed to various platforms






