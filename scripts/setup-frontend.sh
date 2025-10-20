#!/bin/bash

# Setup script for Frontend Repository (Kaiburr_Task_3)
# This script helps set up the CI/CD pipeline for the frontend

echo "🚀 Setting up Frontend CI/CD Pipeline"
echo "====================================="

# Check if we're in the right directory
if [ ! -f "package.json" ]; then
    echo "❌ Error: package.json not found. Please run this script from the frontend repository root."
    exit 1
fi

echo "✅ Found package.json - Frontend repository detected"

# Create .github/workflows directory
mkdir -p .github/workflows
echo "✅ Created .github/workflows directory"

# Copy CI workflow
if [ -f "../CICD/frontend-ci.yml" ]; then
    cp ../CICD/frontend-ci.yml .github/workflows/ci.yml
    echo "✅ Copied CI workflow"
else
    echo "❌ Error: frontend-ci.yml not found in CICD directory"
    exit 1
fi

# Copy Docker workflow
if [ -f "../CICD/frontend-docker.yml" ]; then
    cp ../CICD/frontend-docker.yml .github/workflows/docker.yml
    echo "✅ Copied Docker workflow"
else
    echo "❌ Error: frontend-docker.yml not found in CICD directory"
    exit 1
fi

# Copy Dockerfile
if [ -f "../CICD/Dockerfile.frontend" ]; then
    cp ../CICD/Dockerfile.frontend Dockerfile
    echo "✅ Copied Dockerfile"
else
    echo "❌ Error: Dockerfile.frontend not found in CICD directory"
    exit 1
fi

# Copy nginx.conf
if [ -f "../CICD/nginx.conf" ]; then
    cp ../CICD/nginx.conf nginx.conf
    echo "✅ Copied nginx.conf"
else
    echo "❌ Error: nginx.conf not found in CICD directory"
    exit 1
fi

# Update .gitignore
if ! grep -q "node_modules/" .gitignore 2>/dev/null; then
    echo "" >> .gitignore
    echo "# Dependencies" >> .gitignore
    echo "node_modules/" >> .gitignore
    echo "dist/" >> .gitignore
    echo ".env.local" >> .gitignore
    echo ".env.development.local" >> .gitignore
    echo ".env.test.local" >> .gitignore
    echo ".env.production.local" >> .gitignore
    echo "✅ Updated .gitignore"
fi

# Test npm build
echo "🔨 Testing npm build..."
if npm ci && npm run type-check && npm run build; then
    echo "✅ npm build successful"
else
    echo "❌ npm build failed. Please check your setup."
    exit 1
fi

echo ""
echo "🎉 Frontend CI/CD setup complete!"
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
echo "  docker build -t task-frontend ."
echo "  docker run -p 3000:80 task-frontend"
