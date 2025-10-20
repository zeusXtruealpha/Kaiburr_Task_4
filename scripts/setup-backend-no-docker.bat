@echo off
REM Setup script for Backend Repository (Kaiburr_Task_1) - No Docker
REM This script helps set up the CI/CD pipeline for the backend without Docker

echo 🚀 Setting up Backend CI/CD Pipeline (No Docker)
echo ================================================

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
if exist "..\CICD\backend-ci-no-docker.yml" (
    copy "..\CICD\backend-ci-no-docker.yml" ".github\workflows\ci.yml" >nul
    echo ✅ Copied CI workflow (no Docker)
) else (
    echo ❌ Error: backend-ci-no-docker.yml not found in CICD directory
    pause
    exit /b 1
)

REM Copy deploy workflow
if exist "..\CICD\backend-deploy.yml" (
    copy "..\CICD\backend-deploy.yml" ".github\workflows\deploy.yml" >nul
    echo ✅ Copied deploy workflow
) else (
    echo ❌ Error: backend-deploy.yml not found in CICD directory
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

REM Test Maven test
echo 🧪 Testing Maven tests...
mvn -B test
if errorlevel 1 (
    echo ⚠️  Maven tests failed. Check test configuration.
) else (
    echo ✅ Maven tests successful
)

echo.
echo 🎉 Backend CI/CD setup complete (No Docker)!
echo.
echo Features included:
echo ✅ Maven build and test
echo ✅ JUnit test reporting
echo ✅ Security scanning (OWASP)
echo ✅ JAR artifact upload
echo ✅ Multiple deployment options
echo.
echo Next steps:
echo 1. Commit and push changes:
echo    git add .
echo    git commit -m "Add CI/CD pipeline (no Docker)"
echo    git push origin main
echo 2. Check GitHub Actions tab for workflow runs
echo 3. Configure deployment secrets if needed:
echo    - AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY (for S3)
echo    - AZURE_STORAGE_ACCOUNT, AZURE_STORAGE_KEY (for Azure)
echo    - GCP_SA_KEY (for Google Cloud)
echo.
echo Test commands:
echo   mvn clean test
echo   mvn clean package
echo.
pause
