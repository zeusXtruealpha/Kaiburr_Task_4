#!/bin/bash

# Setup script for Backend Repository (Kaiburr_Task_1)
# This script helps set up the CI/CD pipeline for the backend

echo "🚀 Setting up Backend CI/CD Pipeline"
echo "====================================="

# Check if we're in the right directory
if [ ! -f "pom.xml" ]; then
    echo "❌ Error: pom.xml not found. Please run this script from the backend repository root."
    exit 1
fi

echo "✅ Found pom.xml - Backend repository detected"

# Create .github/workflows directory
mkdir -p .github/workflows
echo "✅ Created .github/workflows directory"

# Copy CI workflow
if [ -f "../CICD/backend-ci.yml" ]; then
    cp ../CICD/backend-ci.yml .github/workflows/ci.yml
    echo "✅ Copied CI workflow"
else
    echo "❌ Error: backend-ci.yml not found in CICD directory"
    exit 1
fi

# Copy Docker workflow
if [ -f "../CICD/backend-docker.yml" ]; then
    cp ../CICD/backend-docker.yml .github/workflows/docker.yml
    echo "✅ Copied Docker workflow"
else
    echo "❌ Error: backend-docker.yml not found in CICD directory"
    exit 1
fi

# Copy Dockerfile
if [ -f "../CICD/Dockerfile.backend" ]; then
    cp ../CICD/Dockerfile.backend Dockerfile
    echo "✅ Copied Dockerfile"
else
    echo "❌ Error: Dockerfile.backend not found in CICD directory"
    exit 1
fi

# Update .gitignore
if ! grep -q "target/" .gitignore 2>/dev/null; then
    echo "" >> .gitignore
    echo "# Maven" >> .gitignore
    echo "target/" >> .gitignore
    echo ".mvn/wrapper/maven-wrapper.jar" >> .gitignore
    echo "✅ Updated .gitignore"
fi

# Test Maven build
echo "🔨 Testing Maven build..."
if mvn -B clean compile -DskipTests; then
    echo "✅ Maven build successful"
else
    echo "❌ Maven build failed. Please check your setup."
    exit 1
fi

echo ""
echo "🎉 Backend CI/CD setup complete!"
echo ""
echo "Next steps:"
echo "1. Add GitHub secrets: DOCKERHUB_USERNAME, DOCKERHUB_TOKEN"
echo "2. Commit and push changes:"
echo "   git add ."
echo "   git commit -m 'Add CI/CD pipeline'"
echo "   git push origin main"
echo "3. Check GitHub Actions tab for workflow runs"
echo ""
echo "Docker commands to test locally:"
echo "  docker build -t task-backend ."
echo "  docker run -p 8080:8080 task-backend"
