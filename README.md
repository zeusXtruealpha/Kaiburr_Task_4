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

**BACKEND**
- <img width="962" height="290" alt="image" src="https://github.com/user-attachments/assets/dc034de2-c3fe-4609-ae0b-0c97c9a7bda4" />
- <img width="1313" height="704" alt="image" src="https://github.com/user-attachments/assets/f85245ef-d0df-4e61-a617-2fe2dd4a4623" />
- <img width="1306" height="917" alt="image" src="https://github.com/user-attachments/assets/cb4a4157-e6b5-4aae-a912-1fbabd0bafbe" />
- Check run URL: https://api.github.com/repos/zeusXtruealpha/Kaiburr_Task_1/check-runs/53166312808
- Check run HTML: https://github.com/zeusXtruealpha/Kaiburr_Task_1/runs/53166312808
- <img width="1328" height="765" alt="image" src="https://github.com/user-attachments/assets/64ea54b2-4678-4ab3-9af2-f6a3449703a5" />

**FRONTEND**
- <img width="959" height="225" alt="image" src="https://github.com/user-attachments/assets/685a0f7b-3327-4e43-b12d-bfcab75813f3" />
- <img width="1297" height="779" alt="image" src="https://github.com/user-attachments/assets/2bdff0da-6995-4ff8-9350-c0f1337268c2" />
- <img width="1295" height="461" alt="image" src="https://github.com/user-attachments/assets/5adad5e3-a382-4d51-94d6-d641f99d2ed7" />
- Artifact download URL: https://github.com/zeusXtruealpha/Kaiburr_Task_3/actions/runs/18649975367/artifacts/4316149236


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
