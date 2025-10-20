@echo off
REM Setup script for Frontend Repository (Kaiburr_Task_3)
REM This script helps set up the CI/CD pipeline for the frontend

echo 🚀 Setting up Frontend CI/CD Pipeline
echo =====================================

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
if exist "..\CICD\frontend-ci.yml" (
    copy "..\CICD\frontend-ci.yml" ".github\workflows\ci.yml" >nul
    echo ✅ Copied CI workflow
) else (
    echo ❌ Error: frontend-ci.yml not found in CICD directory
    pause
    exit /b 1
)

REM Copy Docker workflow
if exist "..\CICD\frontend-docker.yml" (
    copy "..\CICD\frontend-docker.yml" ".github\workflows\docker.yml" >nul
    echo ✅ Copied Docker workflow
) else (
    echo ❌ Error: frontend-docker.yml not found in CICD directory
    pause
    exit /b 1
)

REM Copy Dockerfile
if exist "..\CICD\Dockerfile.frontend" (
    copy "..\CICD\Dockerfile.frontend" "Dockerfile" >nul
    echo ✅ Copied Dockerfile
) else (
    echo ❌ Error: Dockerfile.frontend not found in CICD directory
    pause
    exit /b 1
)

REM Copy nginx.conf
if exist "..\CICD\nginx.conf" (
    copy "..\CICD\nginx.conf" "nginx.conf" >nul
    echo ✅ Copied nginx.conf
) else (
    echo ❌ Error: nginx.conf not found in CICD directory
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

echo.
echo 🎉 Frontend CI/CD setup complete!
echo.
echo Next steps:
echo 1. Add GitHub secrets: DOCKERHUB_USERNAME, DOCKERHUB_TOKEN
echo 2. Commit and push changes:
echo    git add .
echo    git commit -m "Add CI/CD pipeline"
echo    git push origin main
echo 3. Check GitHub Actions tab for workflow runs
echo.
echo Docker commands to test locally:
echo   docker build -t task-frontend .
echo   docker run -p 3000:80 task-frontend
echo.
pause
