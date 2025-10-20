# 🚀 Quick Start Guide

## Prerequisites
- Docker installed and running
- GitHub account with access to both repositories
- Docker Hub account (or GitHub Container Registry)

## Step 1: Set up GitHub Secrets

### For Backend Repository (Kaiburr_Task_1)
1. Go to https://github.com/zeusXtruealpha/Kaiburr_Task_1/settings/secrets/actions
2. Add these secrets:
   - `DOCKERHUB_USERNAME`: Your Docker Hub username
   - `DOCKERHUB_TOKEN`: Your Docker Hub access token

### For Frontend Repository (Kaiburr_Task_3)
1. Go to https://github.com/zeusXtruealpha/Kaiburr_Task_3/settings/secrets/actions
2. Add the same secrets as above

## Step 2: Clone and Set Up Repositories

### Backend Setup
```bash
# Clone backend repository
git clone https://github.com/zeusXtruealpha/Kaiburr_Task_1.git
cd Kaiburr_Task_1

# Copy setup files from CICD directory
cp ../CICD/setup-backend.sh .
chmod +x setup-backend.sh
./setup-backend.sh

# Or on Windows
cp ../CICD/setup-backend.bat .
setup-backend.bat
```

### Frontend Setup
```bash
# Clone frontend repository
git clone https://github.com/zeusXtruealpha/Kaiburr_Task_3.git
cd Kaiburr_Task_3

# Copy setup files from CICD directory
cp ../CICD/setup-frontend.sh .
chmod +x setup-frontend.sh
./setup-frontend.sh

# Or on Windows
cp ../CICD/setup-frontend.bat .
setup-frontend.bat
```

## Step 3: Test Locally

### Using Docker Compose
```bash
# From the CICD directory
docker-compose up -d

# Check services
docker-compose ps

# View logs
docker-compose logs -f

# Stop services
docker-compose down
```

### Individual Services
```bash
# Backend only
docker build -f Dockerfile.backend -t task-backend .
docker run -p 8080:8080 task-backend

# Frontend only
docker build -f frontend/Dockerfile -t task-frontend ./frontend
docker run -p 3000:80 task-frontend
```

## Step 4: Deploy to GitHub Actions

1. **Commit and push changes** to both repositories
2. **Check GitHub Actions** tab in each repository
3. **Monitor build progress** and fix any issues
4. **Verify Docker images** are pushed to Docker Hub

## Step 5: Access Your Application

- **Backend API**: http://localhost:8080
- **Frontend App**: http://localhost:3000
- **API Endpoints**: http://localhost:8080/tasks

## Troubleshooting

### Common Issues
1. **Docker build fails**: Check Dockerfile syntax and file paths
2. **Tests fail**: Run tests locally first
3. **Docker push fails**: Verify Docker Hub credentials
4. **Services won't start**: Check port conflicts and dependencies

### Debug Commands
```bash
# Check Docker images
docker images

# Check running containers
docker ps

# View container logs
docker logs <container_name>

# Test API
curl http://localhost:8080/tasks
curl http://localhost:3000/health
```

## Next Steps

1. **Set up monitoring** (Prometheus, Grafana)
2. **Configure SSL/TLS** for production
3. **Set up domain names** and DNS
4. **Implement backup strategies** for MongoDB
5. **Add security scanning** to CI/CD pipeline

---

**You're all set! 🎉**

For detailed information, see the main [README.md](README.md) file.
