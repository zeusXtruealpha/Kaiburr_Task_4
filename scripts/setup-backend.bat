@echo off
REM Setup script for Backend Repository (Kaiburr_Task_1)
REM This script helps set up the CI/CD pipeline for the backend

echo 🚀 Setting up Backend CI/CD Pipeline
echo =====================================

REM Check if we're in the right directory
if not exist "pom.xml" (
    echo ❌ Error: pom.xml not found. Please run this script from the backend repository root.
    pause
    exit /b 1
)

echo ✅ Found pom.xml - Backend repository detected

REM Create .github/workflows directory
if not exist ".github\workflows" mkdir .github\workflows
echo ✅ Created .github\workflows directory

REM Copy CI workflow
if exist "..\CICD\backend-ci.yml" (
    copy "..\CICD\backend-ci.yml" ".github\workflows\ci.yml" >nul
    echo ✅ Copied CI workflow
) else (
    echo ❌ Error: backend-ci.yml not found in CICD directory
    pause
    exit /b 1
)

REM Copy Docker workflow
if exist "..\CICD\backend-docker.yml" (
    copy "..\CICD\backend-docker.yml" ".github\workflows\docker.yml" >nul
    echo ✅ Copied Docker workflow
) else (
    echo ❌ Error: backend-docker.yml not found in CICD directory
    pause
    exit /b 1
)

REM Copy Dockerfile
if exist "..\CICD\Dockerfile.backend" (
    copy "..\CICD\Dockerfile.backend" "Dockerfile" >nul
    echo ✅ Copied Dockerfile
) else (
    echo ❌ Error: Dockerfile.backend not found in CICD directory
    pause
    exit /b 1
)

REM Update .gitignore
findstr /C:"target/" .gitignore >nul 2>&1
if errorlevel 1 (
    echo. >> .gitignore
    echo # Maven >> .gitignore
    echo target/ >> .gitignore
    echo .mvn/wrapper/maven-wrapper.jar >> .gitignore
    echo ✅ Updated .gitignore
)

REM Test Maven build
echo 🔨 Testing Maven build...
mvn -B clean compile -DskipTests
if errorlevel 1 (
    echo ❌ Maven build failed. Please check your setup.
    pause
    exit /b 1
) else (
    echo ✅ Maven build successful
)

echo.
echo 🎉 Backend CI/CD setup complete!
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
echo   docker build -t task-backend .
echo   docker run -p 8080:8080 task-backend
echo.
pause
