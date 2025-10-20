# 🚀 Kaiburr CICD Pipeline Repository

This repository contains all CI/CD pipeline configurations, scripts, and documentation for the Kaiburr Task Management System.

## 📁 Repository Structure

```
Kaiburr_CICD/
├── workflows/           # GitHub Actions workflow files
├── scripts/            # Setup and deployment scripts
├── docker/             # Docker configurations
├── docs/               # Documentation
└── README.md           # This file
```

## 🎯 Project Repositories

- **Backend**: `https://github.com/zeusXtruealpha/Kaiburr_Task_1`
- **Frontend**: `https://github.com/zeusXtruealpha/Kaiburr_Task_3`
- **CICD**: `https://github.com/zeusXtruealpha/Kaiburr_CICD` (this repo)

## 🛠️ Features

### ✅ CI/CD Pipelines
- **Backend CI**: Maven build, test, security scan, artifact upload
- **Frontend CI**: Node.js build, TypeScript check, security scan
- **Deployment**: Multiple deployment options (GitHub Releases, Cloud Storage)
- **Docker Support**: Both with and without Docker configurations

### 🔧 Setup Scripts
- **Backend Setup**: `scripts/setup-backend-no-docker.sh/.bat`
- **Frontend Setup**: `scripts/setup-frontend-no-docker.sh/.bat`
- **Docker Setup**: `scripts/setup-backend.sh/.bat`, `scripts/setup-frontend.sh/.bat`

### 🐳 Docker Configurations
- **Backend Dockerfile**: `docker/Dockerfile.backend`
- **Frontend Dockerfile**: `docker/Dockerfile.frontend`
- **Docker Compose**: `docker/docker-compose.yml`
- **Nginx Config**: `docker/nginx.conf`, `docker/nginx-proxy.conf`

## 🚀 Quick Start

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

## 🔐 Required Secrets

### Backend Repository Secrets
- `AWS_ACCESS_KEY_ID` - AWS access key for S3 deployment
- `AWS_SECRET_ACCESS_KEY` - AWS secret key for S3 deployment
- `AZURE_STORAGE_ACCOUNT` - Azure storage account name
- `AZURE_STORAGE_KEY` - Azure storage key
- `GCP_SA_KEY` - Google Cloud service account key

### Frontend Repository Secrets
- `NETLIFY_AUTH_TOKEN` - Netlify authentication token
- `NETLIFY_SITE_ID` - Netlify site ID
- `VERCEL_TOKEN` - Vercel authentication token
- `VERCEL_ORG_ID` - Vercel organization ID
- `VERCEL_PROJECT_ID` - Vercel project ID

## 🐳 Docker Deployment

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

## 📊 Monitoring

### GitHub Actions
- Go to your repository → Actions tab
- View workflow runs and logs
- Check test results and deployment status

### Build Artifacts
- Backend: JAR files uploaded to GitHub Releases
- Frontend: Static files deployed to various platforms

## 🔧 Troubleshooting

### Common Issues
1. **MongoDB Connection**: Ensure MongoDB is running locally for tests
2. **Node Modules**: Don't commit `node_modules/` - it's in `.gitignore`
3. **Docker Issues**: Use no-Docker workflows if Docker services are down
4. **Secrets**: Ensure all required secrets are configured in repository settings

### Getting Help
- Check workflow logs in GitHub Actions
- Review the documentation in `docs/` folder
- Check the troubleshooting section in individual workflow files

## 📚 Documentation

- [Quick Start Guide](QUICK_START.md)
- [No Docker Guide](NO_DOCKER_GUIDE.md)
- [Docker Setup Guide](DOCKER_GUIDE.md)
- [Deployment Guide](DEPLOYMENT_GUIDE.md)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test the workflows
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🎉 Success!

Your CI/CD pipeline is now ready! The workflows will automatically:
- ✅ Build and test your code
- ✅ Run security scans
- ✅ Deploy to multiple platforms
- ✅ Generate reports and artifacts

Happy coding! 🚀