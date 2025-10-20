#!/bin/bash

# Setup script for Backend Repository (Kaiburr_Task_1) - No Docker
# This script helps set up the CI/CD pipeline for the backend without Docker

echo "🚀 Setting up Backend CI/CD Pipeline (No Docker)"
echo "================================================"

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
if [ -f "../CICD/backend-ci-no-docker.yml" ]; then
    cp ../CICD/backend-ci-no-docker.yml .github/workflows/ci.yml
    echo "✅ Copied CI workflow (no Docker)"
else
    echo "❌ Error: backend-ci-no-docker.yml not found in CICD directory"
    exit 1
fi

# Copy deploy workflow
if [ -f "../CICD/backend-deploy.yml" ]; then
    cp ../CICD/backend-deploy.yml .github/workflows/deploy.yml
    echo "✅ Copied deploy workflow"
else
    echo "❌ Error: backend-deploy.yml not found in CICD directory"
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

# Test Maven test
echo "🧪 Testing Maven tests..."
if mvn -B test; then
    echo "✅ Maven tests successful"
else
    echo "⚠️  Maven tests failed. Check test configuration."
fi

echo ""
echo "🎉 Backend CI/CD setup complete (No Docker)!"
echo ""
echo "Features included:"
echo "✅ Maven build and test"
echo "✅ JUnit test reporting"
echo "✅ Security scanning (OWASP)"
echo "✅ JAR artifact upload"
echo "✅ Multiple deployment options"
echo ""
echo "Next steps:"
echo "1. Commit and push changes:"
echo "   git add ."
echo "   git commit -m 'Add CI/CD pipeline (no Docker)'"
echo "   git push origin main"
echo "2. Check GitHub Actions tab for workflow runs"
echo "3. Configure deployment secrets if needed:"
echo "   - AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY (for S3)"
echo "   - AZURE_STORAGE_ACCOUNT, AZURE_STORAGE_KEY (for Azure)"
echo "   - GCP_SA_KEY (for Google Cloud)"
echo ""
echo "Test commands:"
echo "  mvn clean test"
echo "  mvn clean package"
