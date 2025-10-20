#!/bin/bash

# Setup script for Frontend Repository (Kaiburr_Task_3) - No Docker
# This script helps set up the CI/CD pipeline for the frontend without Docker

echo "🚀 Setting up Frontend CI/CD Pipeline (No Docker)"
echo "================================================="

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
if [ -f "../CICD/frontend-ci-no-docker.yml" ]; then
    cp ../CICD/frontend-ci-no-docker.yml .github/workflows/ci.yml
    echo "✅ Copied CI workflow (no Docker)"
else
    echo "❌ Error: frontend-ci-no-docker.yml not found in CICD directory"
    exit 1
fi

# Copy deploy workflow
if [ -f "../CICD/frontend-deploy.yml" ]; then
    cp ../CICD/frontend-deploy.yml .github/workflows/deploy.yml
    echo "✅ Copied deploy workflow"
else
    echo "❌ Error: frontend-deploy.yml not found in CICD directory"
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

# Test npm audit
echo "🔍 Testing security scan..."
if npm audit --audit-level=moderate; then
    echo "✅ Security scan passed"
else
    echo "⚠️  Security issues found. Check npm audit output."
fi

echo ""
echo "🎉 Frontend CI/CD setup complete (No Docker)!"
echo ""
echo "Features included:"
echo "✅ Node.js build and test"
echo "✅ TypeScript type checking"
echo "✅ ESLint code quality"
echo "✅ Security scanning (npm audit, Snyk)"
echo "✅ Build size reporting"
echo "✅ Multiple deployment options"
echo ""
echo "Next steps:"
echo "1. Commit and push changes:"
echo "   git add ."
echo "   git commit -m 'Add CI/CD pipeline (no Docker)'"
echo "   git push origin main"
echo "2. Check GitHub Actions tab for workflow runs"
echo "3. Configure deployment secrets if needed:"
echo "   - NETLIFY_AUTH_TOKEN, NETLIFY_SITE_ID (for Netlify)"
echo "   - VERCEL_TOKEN, ORG_ID, PROJECT_ID (for Vercel)"
echo "   - AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY (for S3)"
echo "   - AZURE_STATIC_WEB_APPS_API_TOKEN (for Azure)"
echo ""
echo "Test commands:"
echo "  npm ci"
echo "  npm run type-check"
echo "  npm run build"
