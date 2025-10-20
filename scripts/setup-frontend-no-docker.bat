@echo off
REM Setup script for Frontend Repository (Kaiburr_Task_3) - No Docker
REM This script helps set up the CI/CD pipeline for the frontend without Docker

echo 🚀 Setting up Frontend CI/CD Pipeline (No Docker)
echo =================================================

REM Check if we're in the right directory
if not exist "package.json" (
    echo ❌ Error: package.json not found. Please run this script from the frontend repository root.
    pause
    exit /b 1
)

echo ✅ Found package.json - Frontend repository detected

REM Create .github/workflows directory
if not exist ".github\workflows" mkdir .github\workflows
echo ✅ Created .github\workflows directory

REM Copy CI workflow
if exist "..\CICD\frontend-ci-no-docker.yml" (
    copy "..\CICD\frontend-ci-no-docker.yml" ".github\workflows\ci.yml" >nul
    echo ✅ Copied CI workflow (no Docker)
) else (
    echo ❌ Error: frontend-ci-no-docker.yml not found in CICD directory
    pause
    exit /b 1
)

REM Copy deploy workflow
if exist "..\CICD\frontend-deploy.yml" (
    copy "..\CICD\frontend-deploy.yml" ".github\workflows\deploy.yml" >nul
    echo ✅ Copied deploy workflow
) else (
    echo ❌ Error: frontend-deploy.yml not found in CICD directory
    pause
    exit /b 1
)

REM Update .gitignore
findstr /C:"node_modules/" .gitignore >nul 2>&1
if errorlevel 1 (
    echo. >> .gitignore
    echo # Dependencies >> .gitignore
    echo node_modules/ >> .gitignore
    echo dist/ >> .gitignore
    echo .env.local >> .gitignore
    echo .env.development.local >> .gitignore
    echo .env.test.local >> .gitignore
    echo .env.production.local >> .gitignore
    echo ✅ Updated .gitignore
)

REM Test npm build
echo 🔨 Testing npm build...
npm ci
if errorlevel 1 (
    echo ❌ npm install failed. Please check your setup.
    pause
    exit /b 1
)

npm run type-check
if errorlevel 1 (
    echo ❌ TypeScript check failed. Please check your setup.
    pause
    exit /b 1
)

npm run build
if errorlevel 1 (
    echo ❌ npm build failed. Please check your setup.
    pause
    exit /b 1
) else (
    echo ✅ npm build successful
)

REM Test npm audit
echo 🔍 Testing security scan...
npm audit --audit-level=moderate
if errorlevel 1 (
    echo ⚠️  Security issues found. Check npm audit output.
) else (
    echo ✅ Security scan passed
)

echo.
echo 🎉 Frontend CI/CD setup complete (No Docker)!
echo.
echo Features included:
echo ✅ Node.js build and test
echo ✅ TypeScript type checking
echo ✅ ESLint code quality
echo ✅ Security scanning (npm audit, Snyk)
echo ✅ Build size reporting
echo ✅ Multiple deployment options
echo.
echo Next steps:
echo 1. Commit and push changes:
echo    git add .
echo    git commit -m "Add CI/CD pipeline (no Docker)"
echo    git push origin main
echo 2. Check GitHub Actions tab for workflow runs
echo 3. Configure deployment secrets if needed:
echo    - NETLIFY_AUTH_TOKEN, NETLIFY_SITE_ID (for Netlify)
echo    - VERCEL_TOKEN, ORG_ID, PROJECT_ID (for Vercel)
echo    - AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY (for S3)
echo    - AZURE_STATIC_WEB_APPS_API_TOKEN (for Azure)
echo.
echo Test commands:
echo   npm ci
echo   npm run type-check
echo   npm run build
echo.
pause
